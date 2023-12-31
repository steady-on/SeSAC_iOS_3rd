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
    @IBOutlet weak var stateOfReadingLabel: UILabel!
    @IBOutlet weak var bookmarkImageView: UIImageView!
    
    
    func configureBookCell(for data: MyBook) {
        self.layer.cornerRadius = 15
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.darkGray.cgColor
        
        titleLabel.text = data.title
        authorLabel.text = data.author
        coverImageView.image = UIImage(data: data.thumbnail)
        coverImageView.contentMode = .scaleAspectFill
        
        stateOfReadingLabel.text = data.statusOfReading.expression
        
        bookmarkImageView.isHidden = !data.isBookmark
    }
}
