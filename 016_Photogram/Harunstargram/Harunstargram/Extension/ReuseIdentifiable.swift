//
//  ReuseIdentifiable.swift
//  Harunstargram
//
//  Created by Roen White on 2023/09/01.
//

import UIKit

protocol ReuseIdentifiable {
    static var identifier: String { get }
}

extension ReuseIdentifiable {
    static var identifier: String {
        String(describing: Self.self)
    }
}

extension UICollectionViewCell: ReuseIdentifiable {}
