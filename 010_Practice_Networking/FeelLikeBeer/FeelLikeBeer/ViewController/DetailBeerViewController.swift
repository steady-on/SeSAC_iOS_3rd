//
//  DetailBeerViewController.swift
//  FeelLikeBeer
//
//  Created by Roen White on 2023/09/24.
//

import UIKit

final class DetailBeerViewController: UIViewController {
    
    var beer: Beer?
    
    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var descriptionTextView: UITextView!
    @IBOutlet weak private var bestFoodPairingLabel: UILabel!
    @IBOutlet weak private var bestFoodPairTextView: UITextView!
    @IBOutlet weak private var tipLabel: UILabel!
    @IBOutlet weak private var tipTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpDesignForUI()
        configureComponents()
    }
    
    private func setUpDesignForUI() {
        desingView()
        designNameLabel()
        designCommonTextView(descriptionTextView)
        designCommonTextView(bestFoodPairTextView)
        designCommonTextView(tipTextView)
        designLabel(bestFoodPairingLabel)
        designLabel(tipLabel)
    }
    
    private func configureComponents() {
        guard let beer else { return }
        
        nameLabel.text = beer.name
        descriptionTextView.text = beer.description
        bestFoodPairTextView.text = beer.pairingFoodsString
        tipTextView.text = beer.brewersTips
        beer.getBeerImage { image in
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    }
}

extension DetailBeerViewController {
    private func desingView() {
        view.backgroundColor = UIColor.backgroundColor
    }
    
    private func designNameLabel() {
        nameLabel.font = .boldSystemFont(ofSize: 28)
        nameLabel.textColor = .pointColor
        nameLabel.textAlignment = .center
    }
    
    private func designCommonTextView(_ textView: UITextView) {
        textView.font = .systemFont(ofSize: 17)
        textView.textColor = UIColor.fontColor
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.backgroundColor = .clear
    }
    
    private func designLabel(_ label: UILabel) {
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .accentColor
        label.textAlignment = .center
        label.backgroundColor = .blockColor
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
    }
}
