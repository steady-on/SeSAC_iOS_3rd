//
//  UnsplashAPIManager.swift
//  RandomPhotoSearcher
//
//  Created by Roen White on 2023/09/19.
//

import Foundation

struct UnsplashAPIManager {
    
    private static let baseUrl = "https://api.unsplash.com/photos/random"
    private static let headers = [
        "Accept-Version": "v1",
        "Authorization": "Client-ID \(APIKey.unsplashAccessKey)"
    ]
    
    static func fetchRandomImage(for query: String?, completionHandler: @escaping ([UnsplashPhoto]?) -> Void) {
        guard var urlComponents = URLComponents(string: baseUrl) else { return }
        
        let count = URLQueryItem(name: "count", value: "30")
        let query = URLQueryItem(name: "query", value: query ?? "")
        
        urlComponents.queryItems = [count, query]
        
        performRequest(for: urlComponents) { photos in
            guard let photos else {
                completionHandler(nil)
                return
            }
            DispatchQueue.main.async {
                completionHandler(photos)
            }
        }
    }
    
    private static func performRequest(for urlComponents: URLComponents, completionHandler: @escaping ([UnsplashPhoto]?) -> Void) {
        guard let url = urlComponents.url else { return }
        
        let session = URLSession.shared
        var request = URLRequest(url: url, timeoutInterval: 10)
        request.allHTTPHeaderFields = headers
        
        let task = session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print(error!.localizedDescription)
                completionHandler(nil)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completionHandler(nil)
                return
            }

            guard let data, let decodeData = parseJSON(data) else {
                completionHandler(nil)
                return
            }

            completionHandler(decodeData)
        }
        
        task.resume()
    }
    
    private static func parseJSON(_ jsonData: Data) -> [UnsplashPhoto]? {
        let decoder = JSONDecoder()

        do {
            let decodedData = try decoder.decode([UnsplashPhoto].self, from: jsonData)
            return decodedData
        } catch {
            print("Parsing Failed")
            return nil
        }
    }
}
