//
//  BrowseCollectionViewCell.swift
//  Bookworm
//
//  Created by Roen White on 2023/08/02.
//

import UIKit

class BrowseCollectionViewCell: UICollectionViewCell {
    
    var book: Book?

    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 15
    }
    
    func configureCell() {
        guard let book else { return }
        
        coverImageView.image = UIImage(named: book.title)
        titleLabel.text = book.title
        authorLabel.text = book.author
    }
}
