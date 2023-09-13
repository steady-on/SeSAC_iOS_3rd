//
//  LottoViewModel.swift
//  LotteryChecker
//
//  Created by Roen White on 2023/09/13.
//

import Foundation

final class LottoViewModel {
    
    let selectedDrawingNumber = Observable("1084")
    
    
    let drawingNumbers: [Int] = Array(1...1084).reversed()
    
    func titleForRow(_ row: Int) -> String {
        return "\(drawingNumbers[row])"
    }
    
    
}
