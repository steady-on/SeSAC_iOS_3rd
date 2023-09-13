//
//  Lotto.swift
//  PracticeNetworking
//
//  Created by Roen White on 2023/08/09.
//

import Foundation

struct Lotto {
    let drawingNumber: Int
    let drawingDate: String
    let loteryNumber: [Int]
    let bonusNumber: Int
    
    static func getColorName(for number: Int) -> String {
        switch number {
        case 1...10: return "lottoYellow"
        case 11...20: return "lottoBlue"
        case 21...30: return "lottoRed"
        case 31...40: return "lottoGray"
        default: return "lottoGreen"
        }
    }
    
    init(drawingNumber: Int, drawingDate: String, loteryNumber: [Int], bonusNumber: Int) {
        self.drawingNumber = drawingNumber
        self.drawingDate = drawingDate
        self.loteryNumber = loteryNumber
        self.bonusNumber = bonusNumber
    }
    
    init(from data: LottoData) {
        let numbers = [data.drwtNo1, data.drwtNo2, data.drwtNo3, data.drwtNo4, data.drwtNo5, data.drwtNo6]
        
        self.init(drawingNumber: data.drwNo, drawingDate: data.drwNoDate, loteryNumber: numbers, bonusNumber: data.bnusNo)
    }
}
