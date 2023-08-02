//
//  BookTableViewCell.swift
//  Bookworm
//
//  Created by Roen White on 2023/07/31.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    var data: Book?

    @IBOutlet weak var backgroundUIView: UIView!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var stateOfReadingLabel: UILabel!
    @IBOutlet weak var bookmarkImage: UIImageView!
    @IBOutlet weak var stateOfReadingButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .systemGray6
        backgroundUIView.clipsToBounds = true
        backgroundUIView.layer.cornerRadius = 15
        coverImageView.contentMode = .scaleAspectFill
    }
    
    func configureCell() {
        guard let data else { return }
        
        coverImageView.image = UIImage(named: data.title)
        titleLabel.text = data.title
        authorLabel.text = data.author
        stateOfReadingLabel.text = data.stateOfReading.expression
        bookmarkImage.isHidden = !data.isBookmark
        changeStateOfReading(stateOfReadingButton, defaultValue: data.stateOfReading)
    }
    
    func changeStateOfReading(_ sender: UIButton, defaultValue: StateOfReading) {
        let row = sender.tag
        
        let notYet = UIAction(title: "아직 안읽음", image: UIImage(systemName: "book.closed")) { _ in
            bookData[row].stateOfReading = .notYet
        }
        
        let reading = UIAction(title: "읽는 중", image: UIImage(systemName: "book")) { _ in
            bookData[row].stateOfReading = .reading
        }
        
        let finished = UIAction(title: "다 읽음", image: UIImage(systemName: "book")) { _ in
            bookData[row].stateOfReading = .finished
        }
        
        switch defaultValue {
        case .notYet:
            notYet.state = .on
        case .reading:
            reading.state = .on
        case .finished:
            finished.state = .on
        }
        
        let menu = UIMenu(title: "읽기 상태", options: .singleSelection, children: [notYet, reading, finished])
        
        sender.menu = menu
    }
}
