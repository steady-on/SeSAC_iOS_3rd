//
//  TrendRankingTableViewCell.swift
//  AkiPedia
//
//  Created by Roen White on 2023/08/21.
//

import UIKit

class TrendRankingTableViewCell: UITableViewCell, ReuseIdentifying {

    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewTextView: UITextView!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var mediaTypeLabel: MediaTypeLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUpDesignForUI()
    }
    
    override func prepareForReuse() {
        resetCellInfo()
    }
    
    private func setUpDesignForUI() {
        designBackdropImageView()
        designTitleLabel()
        designOverviewTextView()
        designGenresLabel()
    }
    
    private func resetCellInfo() {
        backdropImageView.image = nil
        titleLabel.text = nil
        overviewTextView.text = ""
        genresLabel.text = nil
    }
}

extension TrendRankingTableViewCell {
    private func designBackdropImageView() {
        backdropImageView.layer.cornerRadius = 15
    }
    
    private func designTitleLabel() {
        titleLabel.font = .preferredFont(forTextStyle: .body)
        titleLabel.numberOfLines = 0
    }
    
    private func designOverviewTextView() {
        overviewTextView.font = .preferredFont(forTextStyle: .callout)
        overviewTextView.textColor = .lightGray
        overviewTextView.isScrollEnabled = false
        overviewTextView.isEditable = false
        overviewTextView.isSelectable = false
    }
    
    private func designGenresLabel() {
        genresLabel.font = .preferredFont(forTextStyle: .caption1)
        genresLabel.numberOfLines = 0
    }
    
    func designMediaTypeLabel(_ mediaType: MediaType) {
        let mediaType = MediaTypeLabelAttribute(mediaType: mediaType)
        
        mediaTypeLabel.text = mediaType.text
        mediaTypeLabel.font = .preferredFont(forTextStyle: .caption1)
        mediaTypeLabel.textColor = mediaType.textColor
        mediaTypeLabel.backgroundColor = mediaType.backgroundColor
        mediaTypeLabel.layer.cornerRadius = 5
        mediaTypeLabel.layer.masksToBounds = true
    }
}

fileprivate enum MediaTypeLabelAttribute: String {
    case movie
    case tv
    
    init(mediaType: MediaType) {
        switch mediaType {
        case .movie: self = .movie
        case .tv: self = .tv
        }
    }
    
    var text: String {
        switch self {
        case .movie: return self.rawValue.capitalized
        case .tv: return self.rawValue.uppercased()
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .movie: return .systemIndigo.withAlphaComponent(0.3)
        case .tv: return .systemPink.withAlphaComponent(0.3)
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .movie: return .systemIndigo
        case .tv: return .systemPink
        }
    }
}
