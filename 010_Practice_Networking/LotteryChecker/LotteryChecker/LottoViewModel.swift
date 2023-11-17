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
    
    private let drawingNumbers = Array(1...1093).reversed().map { String($0) }
    
    // 처음에 한번 Observable로 선언 후 다른 값으로 교체되지 않음
    let drawingNumbersObservable = Observable.just(
        Array(1...1093).reversed().map { String($0) }
    )
    
    // picker에서 선택된 값을 받아올 프로퍼티
    /// UI에 연결되어서 실패할 가능성이 없기 때문에 relay로 처리
    let selectedDrawingNumber = BehaviorRelay(value: "1093")
    
    struct Input {
        let selectedDrawingNumber: BehaviorRelay<String>
    }
    
    struct Output {
        let drawingNumbersObservable: Observable<[String]>
        let lotto: PublishSubject<Lotto>
    }
    
    func requestLotto(selectedNumber: String) -> Observable<Lotto> {
        return Observable<Lotto>.create { [weak self] response in
            self?.lottoManager.fetchLotto(drawingNumber: selectedNumber) { lotto in
                guard let lotto else {
                    response.onError(LottoError.unknowned)
                    return
                }
                
                response.onNext(lotto)
            }
            
            return Disposables.create()
        }
    }
    
    func transform(input: Input) -> Output {
        let drawingNumbersObservable = Observable.just(drawingNumbers)
        let publishedLotto = PublishSubject<Lotto>()
        
        input.selectedDrawingNumber
            .debounce(.seconds(1), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMap {
                self.requestLotto(selectedNumber: $0)
            }
            .subscribe(with: self) { owner, lotto in
                publishedLotto.onNext(lotto)
            }
            .disposed(by: disposeBag)
        
        return Output(drawingNumbersObservable: drawingNumbersObservable, lotto: publishedLotto)
    }
}
