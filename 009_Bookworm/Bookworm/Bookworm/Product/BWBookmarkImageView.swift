//
//  BWBookmarkImageView.swift
//  Bookworm
//
//  Created by Roen White on 2023/09/06.
//

import UIKit

class BWBookmarkImageView: UIImageView {
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//        configureView()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func draw(_ rect: CGRect) {
        configureView()
    }
    
    func configureView() {
        let sfConfig = UIImage.SymbolConfiguration(scale: .large)
        let image = UIImage(systemName: "bookmark.fill", withConfiguration: sfConfig)
        
        self.image = image
        tintColor = .systemRed
        contentMode = .scaleToFill
    }
}
