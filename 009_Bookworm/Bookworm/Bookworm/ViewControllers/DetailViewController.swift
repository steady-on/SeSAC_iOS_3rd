//
//  DetailViewController.swift
//  Bookworm
//
//  Created by Roen White on 2023/07/31.
//

import UIKit

class DetailViewController: UIViewController {
    
    let placeholder = "내용을 입력해주세요(책속의 한줄/감상평 등)"

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var introduceTextView: UITextView!
    @IBOutlet weak var userMemoTextView: UITextView!
    
    var myBook: MyBook?
    
    var book: Book?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDetailView()
        configureView()
        userMemoTextView.delegate = self
    }
    
    func configureView() {
        if let myBook {
            title = myBook.title
            
            backgroundImageView.image = UIImage(data: myBook.thumbnail)
            backgroundImageView.contentMode = .scaleAspectFill
            backgroundImageView.applyBlurEffect()
            
            coverImageView.image = UIImage(data: myBook.thumbnail)
            
            titleLabel.text = myBook.title
            authorLabel.text = myBook.author
            
            introduceTextView.text = myBook.introduce
        }
        
        if let book {
            title = book.title
            
            if let localImgage = UIImage(named: book.title) {
                backgroundImageView.image = localImgage
                coverImageView.image = localImgage
            } else {
                backgroundImageView.loadData(url: book.thumbnail)
                coverImageView.loadData(url: book.thumbnail)
            }

            backgroundImageView.applyBlurEffect()
            backgroundImageView.contentMode = .scaleToFill
            
            titleLabel.text = book.title
            authorLabel.text = book.author
            
            introduceTextView.text = book.overview
        }
    }
    
    func setDetailView() {
        contentView.layer.cornerRadius = 15
        
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
