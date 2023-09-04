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
    @IBOutlet weak var bookmarkImage: UIImageView!
    @IBOutlet weak var stateOfReadingButton: UIButton!
     
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .systemGray6
        backgroundUIView.clipsToBounds = true
        backgroundUIView.layer.cornerRadius = 15
        coverImageView.contentMode = .scaleAspectFill
        stateOfReadingButton.configuration?.buttonSize = .mini
    }
    
    func configureCell() {
        guard let data else { return }
        
        coverImageView.image = UIImage(named: data.title)
        titleLabel.text = data.title
        authorLabel.text = data.author
        bookmarkImage.isHidden = !data.isBookmark
        stateOfReadingButton.menu = makeMenuforStateOfReading(for: stateOfReadingButton.tag, defaultValue: data.stateOfReading)
    }
    
    func makeMenuforStateOfReading(for row: Int, defaultValue: StatusOfReading) -> UIMenu {
        
        let notYet = UIAction(title: "아직 안읽음", image: UIImage(systemName: "book.closed")) { _ in
            localBookData[row].stateOfReading = .notYet
        }
        
        let reading = UIAction(title: "읽는 중", image: UIImage(systemName: "book")) { _ in
            localBookData[row].stateOfReading = .reading
        }
        
        let finished = UIAction(title: "다 읽음", image: UIImage(systemName: "book")) { _ in
            localBookData[row].stateOfReading = .finished
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
        
        return menu
    }
}
