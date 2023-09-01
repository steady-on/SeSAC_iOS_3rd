//
//  BaseCollectionViewCell.swift
//  Harunstargram
//
//  Created by Roen White on 2023/09/01.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureCell()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell() {}
    func setConstraints() {}
}
