//
//  ViewController.swift
//  FeelLikeBeer
//
//  Created by Roen White on 2023/08/09.
//

import UIKit
import Alamofire
import SwiftyJSON

class RecommandBeerViewController: UIViewController {

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
        
        setUpDesignForUI()
        callRequest()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        presentCoverView()
    }
    
    @IBAction func pickAgainButtonTapped(_ sender: UIButton) {
        callRequest()
        scrollView.setContentOffset(.zero, animated: true)
    }
    
    func presentCoverView() {
        guard let coverViewController = storyboard?.instantiateViewController(withIdentifier: "CoverViewController") as? CoverViewController else { return }
        
        coverViewController.modalPresentationStyle = .overFullScreen
        
        present(coverViewController, animated: false)
    }
    
    func callRequest() {
        let url = "https://api.punkapi.com/v2/beers/random"
        
        AF.request(url, method: .get).validate().responseJSON { [self] response in
            switch response.result {
            case .success(let value):
                guard let json = JSON(value).arrayValue.first else { return }
//                print("JSON: \(json)")
                
                nameLabel.text = json["name"].stringValue
                descriptionTextView.text = json["description"].stringValue
                bestFoodPairTextView.text = json["food_pairing"].arrayValue.map { $0.stringValue }.joined(separator: ",\n")
                tipTextView.text = json["brewers_tips"].stringValue
                
                getImageToURL(json["image_url"].stringValue) { image in
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getImageToURL(_ url: String, completionHandler: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: url) else { return }
        var photoImage: UIImage? = nil
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print("에러있음: \(error!)")
            }
            // 옵셔널 바인딩
            guard let imageData = data else { return }
            
            // 데이터를 UIImage 타입으로 변형
            photoImage = UIImage(data: imageData)
            completionHandler(photoImage)
            
        }.resume()
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
