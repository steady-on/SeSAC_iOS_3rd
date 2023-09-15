//
//  BaseCollectionViewCell.swift
//  Bookworm
//
//  Created by Roen White on 2023/09/06.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {}
    func setConstraints() {}
}
