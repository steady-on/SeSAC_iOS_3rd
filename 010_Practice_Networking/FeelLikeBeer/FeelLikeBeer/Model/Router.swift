//
//  Router.swift
//  FeelLikeBeer
//
//  Created by Roen White on 2023/09/24.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    case random
    case beers(page: Int)
    case singleBeer(id: Int)
    
    private var baseURL: URL? {
        URL(string: "https://api.punkapi.com/v2/beers/")
    }
    
    private var path: String {
        switch self {
        case .random: return "random"
        case .beers: return ""
        case .singleBeer(let id): return "\(id)"
        }
    }
    
    private var method: HTTPMethod { .get }
    
    private var parameters: [String:String] {
        switch self {
        case .random, .singleBeer:
            return [:]
        case .beers(let page):
            return ["page":"\(page)"]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        guard let url = baseURL?.appending(path: path) else {
            throw URLError(.badURL)
        }
        
        var request = try URLRequest(url: url, method: method)
        
        request = try URLEncodedFormParameterEncoder(destination: .queryString).encode(parameters, into: request)
        
        return request
    }
}
