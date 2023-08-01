//
//  SearchTableViewCell.swift
//  Bookworm
//
//  Created by Roen White on 2023/08/02.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    var book: Book?

    @IBOutlet weak var backgroundUIView: UIView!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var introduceTextView: UITextView!
    
    func configureCell() {
        guard let book else { return }
        
        self.backgroundColor = .systemGray6
        
        backgroundUIView.backgroundColor = .systemBackground
        backgroundUIView.layer.cornerRadius = 15
        backgroundUIView.clipsToBounds = true
        
        bookTitleLabel.text = book.title
        authorLabel.text = book.author
        introduceTextView.text = book.introduce
        
        introduceTextView.textContainer.maximumNumberOfLines = 3
        introduceTextView.textContainer.lineBreakMode = .byTruncatingTail
    }
}
