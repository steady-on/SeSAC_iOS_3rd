//
//  BWTableViewCell.swift
//  Bookworm
//
//  Created by Roen White on 2023/09/04.
//

import UIKit
import RealmSwift

class BWTableViewCell: BaseTableViewCell {
    
    var myBook: MyBook? {
        didSet {
            guard let myBook else { return }
            
            coverImageView.image = UIImage(data: myBook.thumbnail)
            titleLabel.text = myBook.title
            authorLabel.text = myBook.author
            bookmarkImageView.isHidden = !myBook.isBookmark
            changeStatusOfReadingButton.menu = makeMenuForStatusOfReading()
            changeStatusOfReadingButton.showsMenuAsPrimaryAction = true
            changeStatusOfReadingButton.setTitle(myBook.statusOfReading.expression, for: .normal)
            
            overviewTextView.isHidden = true
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
            overviewTextView.text = book.overview
            
            bookmarkImageView.isHidden = true
            changeStatusOfReadingButton.isHidden = true
        }
    }
    
    private let backdropView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let infoTextStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .leading
//        stackView.distribution = .equalSpacing
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
    
    private let overviewTextView: UITextView = {
        let textView = UITextView()
        textView.font = .preferredFont(forTextStyle: .callout)
        textView.textColor = .secondaryLabel
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.textContainer.lineBreakMode = .byTruncatingTail
        textView.textContainerInset = .zero
        textView.textContainer.lineFragmentPadding = .zero
        return textView
    }()
    
    private let bookmarkImageView: UIImageView = BWBookmarkImageView(frame: .zero)
    
    private let changeStatusOfReadingButton: UIButton = {
        let button = UIButton()
        
        var config = UIButton.Configuration.gray()
        config.baseForegroundColor = .systemPink
        config.buttonSize = .mini
        config.cornerStyle = .capsule
        
        let symbolConfig = UIImage.SymbolConfiguration(scale: .small)
        config.image = UIImage(systemName: "chevron.up.chevron.down", withConfiguration: symbolConfig)
        config.imagePlacement = .trailing
        config.imagePadding = 8
        
        button.configuration = config

        return button
    }()
    
    override func configureView() {
        contentView.backgroundColor = .secondarySystemGroupedBackground
        contentView.addSubview(backdropView)
        backdropView.translatesAutoresizingMaskIntoConstraints = false
        
        let components = [coverImageView, bookmarkImageView, changeStatusOfReadingButton, infoTextStackView]
        
        components.forEach { component in
            backdropView.addSubview(component)
            component.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let stackComponents = [titleLabel, authorLabel, overviewTextView]
        
        stackComponents.forEach { component in
            infoTextStackView.addArrangedSubview(component)
        }
        
        titleLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        overviewTextView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
    }
    
    override func setConstraints() {
        NSLayoutConstraint.activate([
            backdropView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            backdropView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            backdropView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            backdropView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            coverImageView.topAnchor.constraint(equalTo: backdropView.topAnchor),
            coverImageView.leadingAnchor.constraint(equalTo: backdropView.leadingAnchor),
            coverImageView.bottomAnchor.constraint(equalTo: backdropView.bottomAnchor),
            coverImageView.widthAnchor.constraint(equalTo: coverImageView.heightAnchor, multiplier: 2/3),
            coverImageView.heightAnchor.constraint(equalTo: backdropView.heightAnchor, multiplier: 1)
        ])
        
        NSLayoutConstraint.activate([
            infoTextStackView.topAnchor.constraint(equalTo: backdropView.layoutMarginsGuide.topAnchor),
            infoTextStackView.leadingAnchor.constraint(equalTo: coverImageView.trailingAnchor, constant: 12),
            infoTextStackView.trailingAnchor.constraint(equalTo: backdropView.layoutMarginsGuide.trailingAnchor),
            infoTextStackView.bottomAnchor.constraint(lessThanOrEqualTo: backdropView.layoutMarginsGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            bookmarkImageView.topAnchor.constraint(equalTo: coverImageView.topAnchor),
            bookmarkImageView.leadingAnchor.constraint(equalTo: coverImageView.leadingAnchor, constant: 8),
            bookmarkImageView.widthAnchor.constraint(equalTo: coverImageView.widthAnchor, multiplier: 0.18),
            bookmarkImageView.heightAnchor.constraint(equalTo: bookmarkImageView.widthAnchor, multiplier: 1.5)
        ])

        NSLayoutConstraint.activate([
            changeStatusOfReadingButton.trailingAnchor.constraint(equalTo: backdropView.layoutMarginsGuide.trailingAnchor, constant: -8),
            changeStatusOfReadingButton.bottomAnchor.constraint(equalTo: backdropView.layoutMarginsGuide.bottomAnchor, constant: -8)
        ])
    }
    
    private func makeMenuForStatusOfReading() -> UIMenu {
        let realm = try! Realm()
        
        let actions: [UIAction] = StatusOfReading.allCases.map { status in
            UIAction(title: status.expression, image: UIImage(systemName: status.iconName)) { _ in
                try! realm.write {
                    self.myBook?.statusOfReading = status
                    self.changeStatusOfReadingButton.setTitle(status.expression, for: .normal)
                }
            }
        }
        
        if let status = myBook?.statusOfReading {
            actions[status.rawValue].state = .on
        }
        
        let menu = UIMenu(title: "읽기 상태", options: .singleSelection, children: actions)
        
        return menu
    }
}
