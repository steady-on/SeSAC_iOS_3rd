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
    @IBOutlet weak var ratingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUpDesignForUI()
    }
    
    var media: MediaProtocol? {
        didSet {
            guard let media else { return }
            
            switch media.mediaType {
            case .movie:
                guard let movie = media as? Movie else { return }
                
                self.backdropImageView.loadTMDBData(url: movie.backdropPath)
                self.titleLabel.text = movie.title
                self.overviewTextView.text = movie.overview
                self.genresLabel.text = movie.genres.map { "#" + $0 }.joined(separator: " ")
                self.designMediaTypeLabel(.movie)
                self.ratingLabel.text = "\(String(format: "%.1f", movie.voteAverage))"
                
            case .tv:
                guard let tv = media as? Tv else { return }
                self.backdropImageView.loadTMDBData(url: tv.backdropPath)
                self.titleLabel.text = tv.name
                self.overviewTextView.text = tv.overview
                self.genresLabel.text = tv.genres.map { "#" + $0 }.joined(separator: " ")
                self.designMediaTypeLabel(.tv)
                self.ratingLabel.text = "\(String(format: "%.1f", tv.voteAverage))"
            }
            
        }
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
        genresLabel.font = .preferredFont(forTextStyle: .callout)
        genresLabel.numberOfLines = 0
    }
    
    private func designRatingLabel() {
        ratingLabel.font = .preferredFont(forTextStyle: .callout)
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
