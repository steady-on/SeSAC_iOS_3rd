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
    
    private let decoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    mutating func goToNextPage() {
        guard BeerManager.page < 13 else { return }
        BeerManager.page += 1
    }
    
    // Get a Single Beer
    func requestSpecifiedBeer(for id: Int, completion: @escaping (Result<Beer, Error>) -> Void) {
        let url = url + "\(id)"
        
        AF.request(url, method: .get).responseDecodable(of: Beer.self, decoder: decoder) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    // Get Random Beer
    func fetchRandomBeer(completion: @escaping (Result<Beer, Error>) -> ()) {
        let url = url + "/random"
        AF.request(url, method: .get).responseDecodable(of: Beer.self, decoder: decoder) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    // Get Beers + pagenation
    func fetchPagingBeerData(completion: @escaping (Result<[Beer], Error>) -> ()) {
        
        let parameters: Parameters = ["page": "\(BeerManager.page)"]
        
        AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding(destination: .queryString)).responseDecodable(of: [Beer].self, decoder: decoder) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
