//
//  BWCollectionViewCell.swift
//  Bookworm
//
//  Created by Roen White on 2023/09/06.
//

import UIKit

class BWCollectionViewCell: BaseCollectionViewCell {
    
    var myBook: MyBook? {
        didSet {
            guard let myBook else { return }
            
            coverImageView.image = UIImage(data: myBook.thumbnail)
            titleLabel.text = myBook.title
            authorLabel.text = myBook.author
            statusOfReadingLabel.text = myBook.statusOfReading.expression
            bookmarkImageView.isHidden = !myBook.isBookmark
        }
    }
    
    var book: Book? {
        didSet {
            guard let book else { return }
            
            if let image = UIImage(named: book.title) {
                coverImageView.image = image
            } else {
                coverImageView.loadData(url: book.thumbnail)
            }
            
            titleLabel.text = book.title
            authorLabel.text = book.author
            
            statusOfReadingLabel.isHidden = true
            bookmarkImageView.isHidden = true
        }
    }
    
    private let coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let infoView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground.withAlphaComponent(0.8)
        return view
    }()
    
    private let infoTextStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.alignment = .leading
        stackView.distribution = .fill
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .callout)
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        return label
    }()
    
    private let statusOfReadingLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption1)
        label.textColor = .systemPink
        return label
    }()
    
    private let bookmarkImageView: UIImageView = BWBookmarkImageView(frame: .zero)
    
    override func configureView() {
        contentView.layer.cornerRadius = 15
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.systemGray.cgColor
        contentView.clipsToBounds = true
        
        let components = [coverImageView, infoView, infoTextStackView, bookmarkImageView]
        
        components.forEach { component in
            contentView.addSubview(component)
            component.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let stackComponents = [titleLabel, authorLabel, statusOfReadingLabel]
        
        stackComponents.forEach { component in
            infoTextStackView.addArrangedSubview(component)
        }
    }
    
    override func setConstraints() {
        NSLayoutConstraint.activate([
            coverImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            coverImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            coverImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            coverImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            infoView.leadingAnchor.constraint(equalTo: coverImageView.leadingAnchor),
            infoView.trailingAnchor.constraint(equalTo: coverImageView.trailingAnchor),
            infoView.bottomAnchor.constraint(equalTo: coverImageView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            infoTextStackView.topAnchor.constraint(equalTo: infoView.layoutMarginsGuide.topAnchor),
            infoTextStackView.leadingAnchor.constraint(equalTo: infoView.layoutMarginsGuide.leadingAnchor),
            infoTextStackView.trailingAnchor.constraint(equalTo: infoView.layoutMarginsGuide.trailingAnchor),
            infoTextStackView.bottomAnchor.constraint(equalTo: infoView.layoutMarginsGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            bookmarkImageView.topAnchor.constraint(equalTo: coverImageView.topAnchor),
            bookmarkImageView.leadingAnchor.constraint(equalTo: coverImageView.leadingAnchor, constant: 8),
            bookmarkImageView.widthAnchor.constraint(equalTo: coverImageView.widthAnchor, multiplier: 0.15),
            bookmarkImageView.heightAnchor.constraint(equalTo: bookmarkImageView.widthAnchor, multiplier: 1.5)
        ])
    }
}
