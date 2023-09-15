//
//  ProfileImageView.swift
//  AkiPedia
//
//  Created by Roen White on 2023/08/29.
//

import UIKit

class ProfileImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = frame.width / 2
    }
    
    func configureView() {
        image = UIImage(systemName: "person.fill")
        contentMode = .scaleToFill
        tintColor = .white
        backgroundColor = .systemGray
        layer.borderColor = UIColor.systemGray6.cgColor
        layer.borderWidth = 1
        clipsToBounds = true
    }
}
