//
//  MediaTableViewCell.swift
//  AkiPedia
//
//  Created by Roen White on 2023/08/18.
//

import UIKit

fileprivate enum MediaTypeLabelAttribute: String {
    case movie
    case tv
    
    init(type: MediaType) {
        switch type {
        case .movie: self = .movie
        case .tv: self = .tv
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .movie: return UIColor.systemPink.withAlphaComponent(0.2)
        case .tv: return UIColor.systemIndigo.withAlphaComponent(0.2)
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .movie: return UIColor.systemPink
        case .tv: return UIColor.systemIndigo
        }
    }
}

class MediaTableViewCell: UITableViewCell {

    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var genreHashtagLabel: UILabel!
    @IBOutlet weak var mediaTypeLabel: TintedLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setUpDesignForUI() {
        designMovieTitleLabel()
        designGenreHashtagLabel()
    }
}

extension MediaTableViewCell {
    private func designMovieTitleLabel() {
        movieTitleLabel.font = .preferredFont(forTextStyle: .title3)
        movieTitleLabel.numberOfLines = 0
    }
    
    private func designGenreHashtagLabel() {
        genreHashtagLabel.font = .preferredFont(forTextStyle: .body)
        genreHashtagLabel.textColor = .gray
        genreHashtagLabel.numberOfLines = 0
    }
    
    private func configureMediaTypeLabel(for type: MediaTypeLabelAttribute) {
        mediaTypeLabel.text = type.rawValue
        mediaTypeLabel.textColor = type.textColor
        mediaTypeLabel.backgroundColor = type.backgroundColor
        mediaTypeLabel.layer.cornerRadius = 15
    }
}
