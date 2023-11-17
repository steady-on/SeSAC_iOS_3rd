//
//  LottoViewModel.swift
//  LotteryChecker
//
//  Created by Roen White on 2023/09/13.
//

import Foundation

final class LottoViewModel {
    
    private lazy var lottoManager = LottoManager()
    
    private let drawingNumbers = Array(1...1084).reversed().map { String($0) }
    var numberOfDrawingNumbers: Int { drawingNumbers.count }
    
    let selectedNumber: CustomObservable<String?> = CustomObservable("1084")
    let seletedDrawingNumberLable = CustomObservable("")
    
    let lotto: CustomObservable<Lotto?> = CustomObservable(nil)

    func titleForRow(_ row: Int) -> String {
        return drawingNumbers[row]
    }
    
    func setPickerValueToSelectedNumber(for row: Int) {
        selectedNumber.value = drawingNumbers[row]
    }
    
    func textForDrawingNumberLabel() {
        guard let selectedNumber = selectedNumber.value else {
            seletedDrawingNumberLable.value = "회차 정보가 올바르지 않습니다."
            return
        }
        
        seletedDrawingNumberLable.value = "\(selectedNumber)회 당첨 번호"
    }
    
    func requestLotto() {
        guard let drawingNumber = selectedNumber.value else { return }
        
        lottoManager.fetchLotto(drawingNumber: drawingNumber) { lotto in
            guard let lotto else {
                self.seletedDrawingNumberLable.value = "회차 정보를 불러오지 못했습니다."
                return
            }
            
            self.lotto.value = lotto
        }
    }
}
