//
//  ReusableViewProtocol.swift
//  Bookworm
//
//  Created by Roen White on 2023/08/12.
//

import UIKit

protocol ReusableIdentifiable {
    static var identifier: String { get }
}

extension ReusableIdentifiable {
    static var identifier: String {
        String(describing: Self.self)
    }
}

extension UIViewController: ReusableIdentifiable {}

extension UITableViewCell: ReusableIdentifiable {}

extension UICollectionViewCell: ReusableIdentifiable {}
