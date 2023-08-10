//
//  BeerManager.swift
//  FeelLikeBeer
//
//  Created by Roen White on 2023/08/10.
//

import Foundation
import Alamofire
import SwiftyJSON

struct BeerManager {
    private let url = "https://api.punkapi.com/v2/beers/"
    
    func fetchRandomBeer(completion: @escaping (Beer) -> ()) {
        let url = url + "random"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                guard let json = JSON(value).arrayValue.first else { return }
                
                let name = json["name"].stringValue
                let description = json["description"].stringValue
                let pairingFoods = json["food_pairing"].arrayValue.map { $0.stringValue }
                let tip = json["brewers_tips"].stringValue
                let imageUrl = json["image_url"].stringValue
                
                let beer = Beer(name: name, description: description, pairingFoods: pairingFoods, tip: tip, imageUrl: imageUrl)
                
                completion(beer)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
