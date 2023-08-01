//
//  DetailViewController.swift
//  Bookworm
//
//  Created by Roen White on 2023/07/31.
//

import UIKit

class DetailViewController: UIViewController {
    
    var book: Book?

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var introduceTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setDetailView()
    }
    
    func setDetailView() {
        contentView.layer.cornerRadius = 15
        guard let book else { return }
        
        title = book.title

        backgroundImageView.image = UIImage(named: book.title)
        backgroundImageView.contentMode = .bottom
        backgroundImageView.applyBlurEffect()
        
        coverImageView.image = UIImage(named: book.title)

        titleLabel.text = book.title
        authorLabel.text = book.author
        
        introduceTextView.text = book.introduce
    }
}
