//
//  KakaoAPIManager.swift
//  VideoSearcher
//
//  Created by Roen White on 2023/08/17.
//

import Foundation

enum NetworkError: Error, CustomDebugStringConvertible {
    case jsonParsingError
    case performRequestError
    
    var debugDescription: String {
        switch self {
        case .jsonParsingError:
            return "Failed to parse data"
        case .performRequestError:
            return "Failed to perform Request"
        }
    }
}

struct KakaoAPIManager {
    private static let url = "https://dapi.kakao.com/v2/search/vclip"
    
    static func search(for keyword: String, completionHandler: @escaping ([Document]) -> Void, errorHandler: @escaping (NetworkError) -> Void) {
        guard var urlComponents = URLComponents(string: KakaoAPIManager.url) else { return }
        
        let query = URLQueryItem(name: "query", value: keyword)
        let size = URLQueryItem(name: "size", value: "\(30)")
        urlComponents.queryItems = [query, size]
        
        performRequest(with: urlComponents) { searchResult in
            let videos = searchResult.documents
            completionHandler(videos)
        } errorHandler: { error in
            errorHandler(error)
        }
    }
    
    private static func performRequest(with urlComponents: URLComponents, completionHandler: @escaping (SearchResult) -> Void, errorHandler: @escaping (NetworkError) -> Void) {
        guard let url = urlComponents.url else { return }
        
        let session = URLSession(configuration: .default)
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.setValue("application/json;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.setValue("KakaoAK 709413ef0b7dbcc05a0eb03b41ad1a20", forHTTPHeaderField: "Authorization")
        
        let task = session.dataTask(with: request) { data, _, error in
            guard error == nil, let data else {
                errorHandler(NetworkError.performRequestError)
                return
            }
            
            do {
                let searchResult = try parseJSON(data)
                completionHandler(searchResult)
            } catch {
                errorHandler(error as! NetworkError)
            }
        }
        
        task.resume()
    }
    
    private static func parseJSON(_ jsonData: Data) throws -> SearchResult {
        let decoder = JSONDecoder()

        do {
            let decodedData = try decoder.decode(SearchResult.self, from: jsonData)
            return decodedData
        } catch {
            throw NetworkError.jsonParsingError
        }
    }
}
