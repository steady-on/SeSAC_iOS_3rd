//
//  LottoViewModel.swift
//  LotteryChecker
//
//  Created by Roen White on 2023/09/13.
//

import Foundation
import RxSwift
import RxCocoa

final class LottoViewModel {
    
    private lazy var lottoManager = LottoManager()
    private let disposeBag = DisposeBag()
    
    private let drawingNumbers = Array(1...1094).reversed().map { String($0) }
    
    // just메서드로 만들어진 Observable은 매개변수로 받은 객체 자체를 Observable로 변환해서 원본 그대로를 방출
    /// Observable은 onNext가 불가능!
    /// picker에 쓰일 숫자 배열은 처음에 한번 Observable로 선언 후 다른 값으로 교체될 필요가 없으므로 굳이 Subject나 relay로 만들 필요가 없음
    let drawingNumbersObservable = Observable.just(
        Array(1...1093).reversed().map { String($0) }
    )
    
    // picker에서 선택된 값을 받아올 프로퍼티
    /// UI에 연결되어서 실패할 가능성이 없기 때문에 relay로 처리
    let selectedDrawingNumber = BehaviorRelay(value: "1094")
    
    struct Input {
        let selectedDrawingNumber: BehaviorRelay<String>
    }
    
    struct Output {
        let drawingNumbersObservable: Observable<[String]>
        let lotto: PublishSubject<Lotto>
    }
    
//    func requestLotto(selectedNumber: String) -> Observable<Lotto> {
//        return Observable<Lotto>.create { [weak self] response in
//            self?.lottoManager.fetchLotto(drawingNumber: selectedNumber) { lotto in
//                guard let lotto else {
//                    response.onError(LottoError.unknowned)
//                    return
//                }
//                
//                // create로 생성된 시퀀스는 동기적임!
//                response.onNext(lotto)
//                response.onCompleted()
//            }
//            
//            /// 그래서 여기서 뭘 반환하더라도 위에 있는 onNext로 전달된 이벤트가 생성/처리되고 completed되는데에는 전혀 문제가 없음
//            /// 그래서 이건 그냥 일반적으로 반환하는 일회용임
//            /// 이게 반환될 일은 없음
//            return Disposables.create()
//        }
//    }

    func requestLotto(selectedNumber: String) -> Single<Lotto> {
        return lottoManager.fetchLotto(drawingNumber: selectedNumber)
    }
    
    func transform(input: Input) -> Output {
        let drawingNumbersObservable = Observable.just(drawingNumbers)
        let publishedLotto = PublishSubject<Lotto>()
        
        input.selectedDrawingNumber
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
        // ???: 네트워크 통신할때 flatMap 왜씀?
        /* 
         - flatMap: transform the items emitted by an Observable into Observables, then flatten the emissions from those into a single Observable
                Observable이 방출한 항목을 Observable로 변환한 다음 해당 항목의 방출을 단일 Observable로 평탄화
         - map: transform the items emitted by an Observable by applying a function to each item
                각 아이템에 함수를 적용하여 Observable에서 방출된 아이템을 변환
        즉, 네트워크 통신에 flatMap을 쓰는게 아니고 두개의 operator의 쓰임이 다른것
         
         requestLotto(selectedNumber:)메서드가 Single을 리턴하니까 당연히 subscribe(onSuccess:onError:)메서드를 써야 할줄 알았는데 그렇게 메서드 체이닝이 불가능함
        - flatMap에서 말하는 평탄화는 변환된 Observable을 그대로 방출하는게 아니라 그 변환된 Observable이 방출하는 결과들을 병합한다는 뜻!
         아래 코드에 map을 적용하면 PrimitiveSequence<SingleTrait, Lotto>를 그대로 리턴, 그래서 map으로 리턴된 어떤 Observable을 구독하려면 subscribe 내에서 또 subscribe를 해줘야 함
         flatMap 적용 시 PrimitiveSequence<SingleTrait, Lotto>.Element(방출하는 그것!)를 리턴! 그래서 그냥 바로 subscribe로 방출 결과를 받아서 사용이 가능!
         */
            .flatMap {
                self.requestLotto(selectedNumber: $0)
                    .catchAndReturn(Lotto(drawingNumber: 0, drawingDate: "회차 정보를 불러오지 못했습니다.", loteryNumber: [], bonusNumber: 0))
            }
        // MARK: error handling
        /// error handling은 catch와 reply 두가지로 나뉨
        /// reply는 지정된 횟수 혹은 무한, 아니면 특정 에러일때 계속 재시도 하는 것임
        /// 근데 이번의 경우는 picker에서 잘못된 값이 들어오는 경우에는 재시도를 계속 해봤자 의미가 없음
        /// 그래서 catch를 사용해 보고자 함
        /// flatMap을 통해서 에러가 전달되면 catchAndReturn 메서드로 잡아보려고 했는데 자꾸 dispose되어버림
        /// 생각해보니 시점의 문제였음! 이미 flatMap을 통해서 error가 넘어오면 그냥 그 시점에서 이 Observable의 생명주기가 끝나버리는 것임
        /// 그래서 flatMap을 통해서 이벤트가 방출되기 전에 이 이벤트가 에러인지 아닌지 판단하고 잡아줄 필요가 있음
        /// request메서드로 리턴된 single자체에 catchAndReturn을 붙여주니까 이제 error가 넘어오지 않고 계속 다음 요청을 할 수가 있게됨
//            .catchAndReturn(Lotto(drawingNumber: 0, drawingDate: "", loteryNumber: [], bonusNumber: 0))
            .debug()
            .subscribe(with: self) { owner, lotto in
                publishedLotto.onNext(lotto)
            }
//    onError: { owner, error in
//                print(error)
//                // 여기서 requestLotto에 대해서 onError로 보내면, view에서 onError를 UI적으로 처리가능
//                publishedLotto.onError(error)
//                // 그런데! 여기서 onError를 던져버리면, 다음 이벤트(피커값을 다시 고르는 경우)를 받지못함
//            } 
            onDisposed: { _ in
                print("disposed")
            }
            .disposed(by: disposeBag)
        
        return Output(drawingNumbersObservable: drawingNumbersObservable, lotto: publishedLotto)
    }
}
