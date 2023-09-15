//
//  Int+.swift
//  VideoSearcher
//
//  Created by Roen White on 2023/08/20.
//

import Foundation

extension Int {
    var convertTimeFormatString: String {
        "\(String(format: "%02d", self/60)):\(String(format: "%02d", self%60))"
    }
}
