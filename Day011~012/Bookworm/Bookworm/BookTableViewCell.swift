//
//  BookTableViewCell.swift
//  Bookworm
//
//  Created by Roen White on 2023/07/31.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var stateOfReadingLabel: UILabel!
    @IBOutlet weak var bookmarkImage: UIImageView!
    
    func configureCell(for data: Book) {
        coverImageView.image = UIImage(named: data.title)
        coverImageView.layer.cornerRadius = 15
        coverImageView.layer.borderWidth = 0.5
        coverImageView.layer.borderColor = UIColor.darkGray.cgColor
        
        titleLabel.text = data.title
        authorLabel.text = data.author
        
        stateOfReadingLabel.text = data.stateOfReading.expression
        
        bookmarkImage.isHidden = !data.isBookmark
    }
}
