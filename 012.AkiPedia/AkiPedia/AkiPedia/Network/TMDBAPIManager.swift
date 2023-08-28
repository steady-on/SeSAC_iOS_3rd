//
//  TMDBAPIManager.swift
//  AkiPedia
//
//  Created by Roen White on 2023/08/28.
//

import Foundation

final class TMDBAPIManager {
    static var shared = TMDBAPIManager()
    
    private init() {}
    
    private let headers = [
        "accept": "application/json",
        "Authorization": "Bearer \(APIKey.theMovieDBAccessToken)"
    ]
    
    private let language = URLQueryItem(name: "language", value: "ko")

    
    private func performRequest<T:Codable>(to urlComponents: URLComponents, completionHandler: @escaping (T) -> ()) {
        guard let url = urlComponents.url else { return }
        
        let session = URLSession.shared
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = HTTPMethod.get.string
        request.allHTTPHeaderFields = headers

        let task = session.dataTask(with: request) { [self] (data, _, error) in
            guard error == nil, let data else {
                print("Error!", error!.localizedDescription)
                return
            }
            
            guard let decodedData: T = parseJSON(data) else {
                print("Error! 데이터 변환 실패")
                return
            }
            
            completionHandler(decodedData)
        }

        task.resume()
    }
    
    private func parseJSON<T:Codable>(_ jsonData: Data) -> T? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(T.self, from: jsonData)
            return decodedData
        } catch {
            print("Parsing Failed")
            return nil
        }
    }
    
    private enum HTTPMethod: String {
        case get
        case post
        case put
        case delete
        
        var string: String {
            return self.rawValue.uppercased()
        }
    }
}
