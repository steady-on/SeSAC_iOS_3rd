//
//  BeerCollectionViewCell.swift
//  FeelLikeBeer
//
//  Created by Roen White on 2023/08/10.
//

import UIKit

class BeerCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var wrappingView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUIDesignForUI()
    }
    
    var beer: Beer? {
        didSet {
            guard let beer else { return }
            beer.getBeerImage { image in
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        
        let targetSize = CGSize(width: layoutAttributes.frame.width, height: 0)
        
        layoutAttributes.frame.size = contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
        
        return layoutAttributes
    }
        
    private func setUIDesignForUI() {
        designWrappingView()
    }
    
    private func designWrappingView() {
        wrappingView.backgroundColor = .blockColor
        wrappingView.layer.cornerRadius = 10
        wrappingView.clipsToBounds = true
    }
}
