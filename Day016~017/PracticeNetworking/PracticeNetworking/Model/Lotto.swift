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
}
