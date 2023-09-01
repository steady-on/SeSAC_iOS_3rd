//
//  UnsplashAPIManager.swift
//  Harunstargram
//
//  Created by Roen White on 2023/09/01.
//

import Foundation

struct UnsplashAPIManager {
    private static let headers = [
        "Accept-Version": "v1",
        "Authorization": "Client-ID \(APIKey.unsplashAccessKey)"
    ]
    
    private static func performRequest(for urlComponents: URLComponents, completionHandler: @escaping ([UnsplashPhoto]?) -> Void) {
        guard let url = urlComponents.url else { return }
        
        let session = URLSession.shared
        var request = URLRequest(url: url, timeoutInterval: 10)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let task = session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print(error!.localizedDescription)
                completionHandler(nil)
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completionHandler(nil)
                return
            }
            
            guard let data, let decodeData = parseJSON(data) else {
                completionHandler(nil)
                return
            }
            
            completionHandler(decodeData)
        }
    }
    
    private static func parseJSON(_ jsonData: Data) -> [UnsplashPhoto]? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
            let decodedData = try decoder.decode([UnsplashPhoto].self, from: jsonData)
            return decodedData
        } catch {
            print("Parsing Failed")
            return nil
        }
    }
}
