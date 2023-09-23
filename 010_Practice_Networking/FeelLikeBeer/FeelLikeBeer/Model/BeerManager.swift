//
//  BeerManager.swift
//  FeelLikeBeer
//
//  Created by Roen White on 2023/08/10.
//

import Foundation
import Alamofire

struct BeerManager {
    static private let decoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    static func request<T: Decodable>(type: T.Type, api: Router, completion: @escaping (Result<T, Error>) -> Void) {
        AF.request(api).responseDecodable(of: T.self, decoder: decoder) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
