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
    
    static func search(for keyword: String, completionHandler: @escaping ([Video]) -> Void, errorHandler: @escaping (NetworkError) -> Void) {
        guard var urlComponents = URLComponents(string: KakaoAPIManager.url) else { return }
        
        let query = URLQueryItem(name: "query", value: keyword)
        let size = URLQueryItem(name: "size", value: "\(30)")
        urlComponents.queryItems = [query, size]
        
        performRequest(with: urlComponents) { videos in
            DispatchQueue.main.async {
                completionHandler(videos)
            }
        } errorHandler: { error in
            errorHandler(error)
        }
    }
    
    private static func performRequest(with urlComponents: URLComponents, completionHandler: @escaping ([Video]) -> Void, errorHandler: @escaping (NetworkError) -> Void) {
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
                let videos = try parseJSON(data)
                completionHandler(videos)
            } catch {
                errorHandler(NetworkError.jsonParsingError)
            }
        }
        
        task.resume()
    }
    
    static func parseJSON(_ jsonData: Data) throws -> [Video] {
        let decoder = JSONDecoder()

        do {
            let searchResult = try decoder.decode(SearchResult.self, from: jsonData)
            let documents = searchResult.documents
            let videos = documents.map { document in
                let playTime = document.playTime.convertTimeFormatString
                let relativeDatetime = convertDateFormat(document.datetime)
                
                return Video(title: document.title, author: document.author, relativeDatetime: relativeDatetime, playTime: playTime, thumbnail: document.thumbnail, url: document.url)
            }
            
            return videos
        } catch {
            throw NetworkError.jsonParsingError
        }
    }
}

extension KakaoAPIManager {
    
    
    private static func convertDateFormat(_ date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"  // "2023-08-09T16:45:02.000+09:00"
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Korea")
        
        if let date = dateFormatter.date(from: date) {
            return date.relativeTimeToAbbreviated
        }

        return "정보없음"
    }
}
