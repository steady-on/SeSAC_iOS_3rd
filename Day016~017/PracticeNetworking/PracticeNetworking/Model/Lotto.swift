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
    
    func getImageName(for number: Int) -> String {
        switch number {
        case 1...10: return "yellowball"
        case 11...20: return "blueball"
        case 21...30: return "redball"
        case 31...40: return "grayball"
        default: return "greenball"
        }
    }
}
