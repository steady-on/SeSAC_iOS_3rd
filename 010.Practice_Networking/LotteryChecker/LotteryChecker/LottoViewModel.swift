//
//  LottoViewModel.swift
//  LotteryChecker
//
//  Created by Roen White on 2023/09/13.
//

import Foundation

final class LottoViewModel {
    
    
    private let drawingNumbers = Array(1...1084).reversed().map { String($0) }
    var numberOfDrawingNumbers: Int { drawingNumbers.count }
    
    let selectedNumber: Observable<String?> = Observable("1084")
    let seletedDrawingNumberLable = Observable("1084회차 당첨 번호")
    
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
}
