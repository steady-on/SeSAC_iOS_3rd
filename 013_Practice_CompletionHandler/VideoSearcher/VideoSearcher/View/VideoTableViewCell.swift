//
//  VideoTableViewCell.swift
//  VideoSearcher
//
//  Created by Roen White on 2023/08/17.
//

import UIKit

class VideoTableViewCell: UITableViewCell, ReuseIdentifying {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUpDesignForUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
//        thumbnailImageView.image = UIImage(systemName: "photo")
    }
    
    var video: Video? {
        didSet {
            guard let video else { return }
            thumbnailImageView.loadData(url: video.thumbnail)
            titleLabel.text = video.title
            detailLabel.text = video.detailInfo
        }
    }

    func setUpDesignForUI() {
        designTitleLabel()
        designDetailLabel()
    }
}

extension VideoTableViewCell {
    func designTitleLabel() {
        titleLabel.font = .preferredFont(forTextStyle: .body)
        titleLabel.numberOfLines = 0
    }
    
    func designDetailLabel() {
        detailLabel.font = .preferredFont(forTextStyle: .caption1)
        detailLabel.numberOfLines = 1
        detailLabel.textColor = .systemGray
    }
}
