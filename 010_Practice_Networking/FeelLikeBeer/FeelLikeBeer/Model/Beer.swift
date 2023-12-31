//
//  Beer.swift
//  FeelLikeBeer
//
//  Created by Roen White on 2023/08/10.
//

import UIKit

struct Beer: Decodable, Hashable {
    let id: Int
    let name: String
    let description: String
    let foodPairing: [String]
    let brewersTips: String
    let imageUrl: String
    
    var pairingFoodsString: String {
        foodPairing.joined(separator: ",\n")
    }
    
    func getBeerImage(completionHandler: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: imageUrl) else { return }
        var beerImage: UIImage? = nil
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil { print("에러있음: \(error!)") }

            guard let imageData = data else { return }
            
            beerImage = UIImage(data: imageData)
            completionHandler(beerImage)
        }.resume()
    }
}
