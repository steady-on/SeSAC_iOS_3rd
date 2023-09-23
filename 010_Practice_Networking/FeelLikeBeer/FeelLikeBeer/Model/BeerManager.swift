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
    private let url = "https://api.punkapi.com/v2/beers"
    static private var page = 1
    
    mutating func goToNextPage() {
        guard BeerManager.page < 13 else { return }
        BeerManager.page += 1
    }
    
    func fetchRandomBeer(completion: @escaping (Beer) -> ()) {
        let url = url + "/random"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                guard let json = JSON(value).arrayValue.first else { return }
                
                let name = json["name"].stringValue
                let description = json["description"].stringValue
                let pairingFoods = json["food_pairing"].arrayValue.map { $0.stringValue }
                let tip = json["brewers_tips"].stringValue
                let imageUrl = json["image_url"].stringValue
                
                let beer = Beer(name: name, description: description, foodPairing: pairingFoods, tip: tip, imageUrl: imageUrl)
                
                completion(beer)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchPagingBeerData(completion: @escaping ([Beer]) -> ()) {
        
        let parameters: Parameters = ["page": "\(BeerManager.page)"]
        
        AF.request(url, method: .get, parameters: parameters).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value).arrayValue
                var beers = [Beer]()
                
                for item in json {
                    let name = item["name"].stringValue
                    let description = item["description"].stringValue
                    let foodPairing = item["food_pairing"].arrayValue.map { $0.stringValue }
                    let tip = item["brewers_tips"].stringValue
                    let imageUrl = item["image_url"].stringValue
                    
                    let beer = Beer(name: name, description: description, foodPairing: foodPairing, tip: tip, imageUrl: imageUrl)
                    
                    beers.append(beer)
                }
                
                completion(beers)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
