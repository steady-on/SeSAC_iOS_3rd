//
//  BookCollectionViewCell.swift
//  Bookworm
//
//  Created by Roen White on 2023/07/31.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    func configureBookCell(for data: Book) {
        self.layer.cornerRadius = 15
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.darkGray.cgColor
        
        titleLabel.text = data.title
        authorLabel.text = data.author
        coverImageView.image = UIImage(named: data.title)
        coverImageView.contentMode = .scaleAspectFill
    }
}
