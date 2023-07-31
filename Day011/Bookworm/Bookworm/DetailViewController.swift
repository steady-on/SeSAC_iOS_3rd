//
//  DetailViewController.swift
//  Bookworm
//
//  Created by Roen White on 2023/07/31.
//

import UIKit

class DetailViewController: UIViewController {
    
    var book: Book?

    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setDetailView()
        
    }
    
    func setDetailView() {
        guard let book else { return }
        
        title = book.title
        
        coverImageView.image = UIImage(named: book.title)
        titleLabel.text = book.title
        authorLabel.text = book.author
    }
}
