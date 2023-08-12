//
//  SearchTableViewCell.swift
//  Bookworm
//
//  Created by Roen White on 2023/08/02.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var backgroundUIView: UIView!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var introduceTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureCell()
    }
    
    var book: Book? {
        didSet {
            guard let book else { return }
            
            bookTitleLabel.text = book.title
            authorLabel.text = book.author
            introduceTextView.text = book.introduce
            coverImageView.loadData(url: book.thumbnail)
        }
    }
    
    private func configureCell() {
        self.backgroundColor = .systemGray6
        
        backgroundUIView.backgroundColor = .systemBackground
        backgroundUIView.layer.cornerRadius = 15
        backgroundUIView.clipsToBounds = true
        
        introduceTextView.textContainer.maximumNumberOfLines = 3
        introduceTextView.textContainer.lineBreakMode = .byTruncatingTail
        introduceTextView.textContainerInset = .zero
        introduceTextView.textContainer.lineFragmentPadding = .zero
    }
}
