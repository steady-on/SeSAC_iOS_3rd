//
//  ViewController.swift
//  FeelLikeBeer
//
//  Created by Roen White on 2023/08/09.
//

import UIKit

final class RecommandBeerViewController: UIViewController {
    
    private let viewModel = RecommandBeerViewModel()
    private var closeCoverView = false

    @IBOutlet weak private var scrollView: UIScrollView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var descriptionTextView: UITextView!
    @IBOutlet weak private var bestFoodPairingLabel: UILabel!
    @IBOutlet weak private var bestFoodPairTextView: UITextView!
    @IBOutlet weak private var tipLabel: UILabel!
    @IBOutlet weak private var tipTextView: UITextView!
    @IBOutlet weak private var pickAgainButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.definesPresentationContext = true
        
        setUpDesignForUI()
        setBeerInfo()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if closeCoverView == false {
            closeCoverView = true
            presentCoverView()
        }
    }
    
    @IBAction func pickAgainButtonTapped(_ sender: UIButton) {
        viewModel.requestRandomBeer()
        scrollView.setContentOffset(.zero, animated: true)
    }
    
    private func presentCoverView() {
        guard let coverViewController = storyboard?.instantiateViewController(withIdentifier: "CoverViewController") as? CoverViewController else { return }
        
        coverViewController.modalPresentationStyle = .overCurrentContext
        
        present(coverViewController, animated: false)
    }
    
    private func setBeerInfo() {
        viewModel.requestRandomBeer()
        viewModel.beerOfToday.bind { beer in
            guard let beer else { return }
            
            self.nameLabel.text = beer.name
            self.descriptionTextView.text = beer.description
            self.bestFoodPairTextView.text = beer.pairingFoodsString
            self.tipTextView.text = beer.brewersTips
            beer.getBeerImage { image in
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }
    }

    private func setUpDesignForUI() {
        desingView()
        designTitleLabel()
        designNameLabel()
        designCommonTextView(descriptionTextView)
        designCommonTextView(bestFoodPairTextView)
        designCommonTextView(tipTextView)
        designLabel(bestFoodPairingLabel)
        designLabel(tipLabel)
        designOneMorePickButton()
    }
}

extension RecommandBeerViewController {
    private func desingView() {
        view.backgroundColor = UIColor.backgroundColor
    }
    
    private func designTitleLabel() {
        titleLabel.text = "Today's Pick For You!"
        titleLabel.numberOfLines = 0
        titleLabel.font = .boldSystemFont(ofSize: 22)
        titleLabel.textColor = .accentColor
        titleLabel.textAlignment = .center
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
    
    private func designOneMorePickButton() {
        var config = UIButton.Configuration.filled()
        
        config.title = "Pick Again!"
        config.buttonSize = .medium
        config.cornerStyle = .capsule
        config.image = UIImage(systemName: "arrow.clockwise")
        config.imagePadding = 5
        
        pickAgainButton.configuration = config
    }
}
