//
//  DetailViewController.swift
//  Bookworm
//
//  Created by Roen White on 2023/07/31.
//

import UIKit

class DetailViewController: UIViewController {
    
    var book: Book?
    let placeholder = "내용을 입력해주세요(책속의 한줄/감상평 등)"

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var introduceTextView: UITextView!
    @IBOutlet weak var userMemoTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDetailView()
        userMemoTextView.delegate = self
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
        
        userMemoTextView.layer.borderWidth = 0.8
        userMemoTextView.layer.borderColor = UIColor.systemGray4.cgColor
        userMemoTextView.layer.cornerRadius = 10
        
        userMemoTextView.text = placeholder
        userMemoTextView.textColor = .gray
    }
}

extension DetailViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if userMemoTextView.text == placeholder {
            userMemoTextView.text = nil
            userMemoTextView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if userMemoTextView.text.isEmpty {
            userMemoTextView.text = placeholder
            userMemoTextView.textColor = .gray
        }
    }
}
