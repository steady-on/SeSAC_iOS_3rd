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
    
    func setUpDesignForUI() {
        designBackdropImageView()
        designTitleLabel()
        designOverviewTextView()
        designGenresLabel()
    }
    
    func resetCellInfo() {
        backdropImageView.image = nil
        titleLabel.text = nil
        overviewTextView.text = ""
        genresLabel.text = nil
    }
}

extension TrendRankingTableViewCell {
    func designBackdropImageView() {
        backdropImageView.layer.cornerRadius = 15
    }
    
    func designTitleLabel() {
        titleLabel.font = .preferredFont(forTextStyle: .title2, compatibleWith: UITraitCollection(legibilityWeight: .bold))
        titleLabel.numberOfLines = 0
    }
    
    func designOverviewTextView() {
        overviewTextView.font = .preferredFont(forTextStyle: .body)
        overviewTextView.textColor = .systemGray5
        overviewTextView.isScrollEnabled = false
        overviewTextView.isEditable = false
        overviewTextView.isSelectable = false
    }
    
    func designGenresLabel() {
        genresLabel.font = .preferredFont(forTextStyle: .callout)
        genresLabel.numberOfLines = 0
    }
}
