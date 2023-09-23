//
//  ViewController.swift
//  FeelLikeBeer
//
//  Created by Roen White on 2023/08/09.
//

import UIKit

class RecommandBeerViewController: UIViewController {
    
    let beerManager = BeerManager()
    var closeCoverView = false

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var bestFoodPairingLabel: UILabel!
    @IBOutlet weak var bestFoodPairTextView: UITextView!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var tipTextView: UITextView!
    @IBOutlet weak var pickAgainButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.definesPresentationContext = true
        
        setUpDesignForUI()
        callRequest()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if closeCoverView == false {
            closeCoverView = true
            presentCoverView()
        }
    }
    
    @IBAction func pickAgainButtonTapped(_ sender: UIButton) {
        callRequest()
        scrollView.setContentOffset(.zero, animated: true)
    }
    
    func presentCoverView() {
        guard let coverViewController = storyboard?.instantiateViewController(withIdentifier: "CoverViewController") as? CoverViewController else { return }
        
        coverViewController.modalPresentationStyle = .overCurrentContext
        
        present(coverViewController, animated: false)
    }
    
    func callRequest() {
        beerManager.request(type: [Beer].self, api: .random) { result in
            switch result {
            case .success(let data):
                guard let beer = data.first else { return }
                self.nameLabel.text = beer.name
                self.descriptionTextView.text = beer.description
                self.bestFoodPairTextView.text = beer.pairingFoodsString
                self.tipTextView.text = beer.brewersTips
                beer.getBeerImage { image in
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }

    func setUpDesignForUI() {
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
    func desingView() {
        view.backgroundColor = UIColor.backgroundColor
    }
    
    func designTitleLabel() {
        titleLabel.text = "Today's Pick For You!"
        titleLabel.numberOfLines = 0
        titleLabel.font = .boldSystemFont(ofSize: 22)
        titleLabel.textColor = .accentColor
        titleLabel.textAlignment = .center
    }
    
    func designNameLabel() {
        nameLabel.font = .boldSystemFont(ofSize: 28)
        nameLabel.textColor = .pointColor
        nameLabel.textAlignment = .center
    }
    
    func designCommonTextView(_ textView: UITextView) {
        textView.font = .systemFont(ofSize: 17)
        textView.textColor = UIColor.fontColor
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.backgroundColor = .clear
    }
    
    func designLabel(_ label: UILabel) {
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .accentColor
        label.textAlignment = .center
        label.backgroundColor = .blockColor
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
    }
    
    func designOneMorePickButton() {
        var config = UIButton.Configuration.filled()
        
        config.title = "Pick Again!"
        config.buttonSize = .medium
        config.cornerStyle = .capsule
        config.image = UIImage(systemName: "arrow.clockwise")
        config.imagePadding = 5
        
        pickAgainButton.configuration = config
    }
}
