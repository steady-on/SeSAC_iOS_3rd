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
