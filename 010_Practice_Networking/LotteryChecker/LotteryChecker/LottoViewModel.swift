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
    
    // 처음에 한번 Observable로 선언 후 다른 값으로 교체되지 않음
    let drawingNumbers = Observable.just(
        Array(1...1093).reversed().map { String($0) }
    )
    
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
}
