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
    case beers
    case singleBeer(id: Int)
    case nextPage
    
    static private var page = 1
    
    private var baseURL: URL? {
        URL(string: "https://api.punkapi.com/v2/beers/")
    }
    
    private var path: String {
        switch self {
        case .random: return "random"
        case .beers: return ""
        case .singleBeer(let id): return "\(id)"
        case .nextPage: return ""
        }
    }
    
    private var method: HTTPMethod { .get }
    
    private var parameters: [String:String] {
        switch self {
        case .random, .singleBeer:
            return [:]
        case .beers:
            Router.page = 1
            return [:]
        case .nextPage:
            Router.goToNextPage()
            return ["page":"\(Router.page)"]
        }
    }
    
    static private func goToNextPage() {
        guard Router.page < 13 else { return }
        Router.page += 1
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
