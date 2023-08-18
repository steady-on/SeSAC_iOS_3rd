//
//  ReuseIdentifying.swift
//  AkiPedia
//
//  Created by Roen White on 2023/08/18.
//

import Foundation

protocol ReuseIdentifying {
    static var identify: String { get }
}

extension ReuseIdentifying {
    static var identify: String {
        String(describing: Self.self)
    }
}
