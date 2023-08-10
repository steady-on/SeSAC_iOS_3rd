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
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUIDesignForUI()
    }
    
    var beer: Beer? {
        didSet {
            guard let beer else { return }
            nameLabel.text = beer.name
            descriptionTextView.text = beer.description
            beer.getBeerImage { image in
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }
    }
    
    func sizeFittingWith(cellWidth: CGFloat) -> CGSize {
        let targetSize = CGSize(width: cellWidth, height: UIView.layoutFittingCompressedSize.height)
        return self.contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
    }
    
    private func setUIDesignForUI() {
        designWrappingView()
        designNameLabel()
        designDescriptionTextView()
    }
    
    private func designWrappingView() {
        wrappingView.backgroundColor = .blockColor
        wrappingView.layer.cornerRadius = 10
        wrappingView.clipsToBounds = true
    }
    
    private func designNameLabel() {
        nameLabel.font = .boldSystemFont(ofSize: 20)
        nameLabel.textColor = .fontColor
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 0
    }
    
    private func designDescriptionTextView() {
        descriptionTextView.font = .systemFont(ofSize: 16)
        descriptionTextView.textColor = .accentColor
        descriptionTextView.textAlignment = .center
        descriptionTextView.backgroundColor = .clear
        
        descriptionTextView.isEditable = false
        descriptionTextView.isSelectable = false
        descriptionTextView.isScrollEnabled = false
    }
}
