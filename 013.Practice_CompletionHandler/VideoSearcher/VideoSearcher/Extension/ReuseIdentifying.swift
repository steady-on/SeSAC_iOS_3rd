//
//  ReuseIdentifying.swift
//  VideoSearcher
//
//  Created by Roen White on 2023/08/17.
//

import Foundation

protocol ReuseIdentifying {
    static var identifier: String { get }
}

extension ReuseIdentifying {
    static var identifier: String {
        return String(describing: Self.self)
    }
}
