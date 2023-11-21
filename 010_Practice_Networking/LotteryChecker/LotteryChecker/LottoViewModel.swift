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
    
    // 처음에 한번 Observable로 선언 후 다른 값으로 교체되지 않음
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
    
    func requestLotto(selectedNumber: String) -> Observable<Lotto> {
        // MARK: Single이라는 애도 알아보자
        return Observable<Lotto>.create { [weak self] response in
            self?.lottoManager.fetchLotto(drawingNumber: selectedNumber) { lotto in
                guard let lotto else {
                    response.onError(LottoError.unknowned)
                    return
                }
                
                // create로 생성된 시퀀스는 동기적임!
                response.onNext(lotto)
                response.onCompleted()
            }
            
            /// 그래서 여기서 뭘 반환하더라도 위에 있는 onNext로 전달된 이벤트가 생성/처리되고 completed되는데에는 전혀 문제가 없음
            /// 그래서 이건 그냥 일반적으로 반환하는 일회용임
            /// 이게 반환될 일은 없음
            return Disposables.create()
        }
        .debug()
    }

    
    func transform(input: Input) -> Output {
        let drawingNumbersObservable = Observable.just(drawingNumbers)
        let publishedLotto = PublishSubject<Lotto>()
        
        input.selectedDrawingNumber
            .debounce(.seconds(1), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
        // ???: 네트워크 통신할때 flatMap 왜씀?
            .flatMap {
                self.requestLotto(selectedNumber: $0)
            }
            .subscribe(with: self) { owner, lotto in
                publishedLotto.onNext(lotto)
            } onError: { owner, error in
                // 여기서 requestLotto에 대해서 onError로 보내면, view에서 onError를 UI적으로 처리가능
                publishedLotto.onError(error)
                // 그런데! 여기서 onError를 던져버리면, 다음 이벤트(피커값을 다시 고르는 경우)를 받지못함
            } onDisposed: { _ in
                print("disposed")
            }
            .disposed(by: disposeBag)
        
        return Output(drawingNumbersObservable: drawingNumbersObservable, lotto: publishedLotto)
    }
}
