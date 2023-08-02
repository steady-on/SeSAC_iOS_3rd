//
//  BookTableViewCell.swift
//  Bookworm
//
//  Created by Roen White on 2023/07/31.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    @IBOutlet weak var backgroundUIView: UIView!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var stateOfReadingLabel: UILabel!
    @IBOutlet weak var bookmarkImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .systemGray6
        backgroundUIView.clipsToBounds = true
        backgroundUIView.layer.cornerRadius = 15
        coverImageView.contentMode = .scaleAspectFill
    }
    
    func configureCell(for data: Book) {
        coverImageView.image = UIImage(named: data.title)
        titleLabel.text = data.title
        authorLabel.text = data.author
        stateOfReadingLabel.text = data.stateOfReading.expression
        bookmarkImage.isHidden = !data.isBookmark
    }
}
