//
//  TMDBAPIManager.swift
//  AkiPedia
//
//  Created by Roen White on 2023/08/18.
//

import Foundation

final class TMDBAPIManager {
    static var shared = TMDBAPIManager()
    
    private init() {}
    
    private let headers = [
        "accept": "application/json",
        "Authorization": "Bearer \(APIKey.theMovieDBAccessToken)"
    ]
    
    private var currentPage: Int = 1
    private var totalPage: Int = 0
    
    func fetchTrendingAllData(pageUp: Bool = false, completionHandler: @escaping ([MediaProtocol]) -> Void,
                              errorHandler: @escaping (TMDBAPINetworkError) -> Void) {
        guard var urlComponents = URLComponents(string: TMDBEndpoint.trending(mediaType: nil).url) else { return }
        
        if pageUp { managePage() }
        
        let language = URLQueryItem(name: "language", value: "ko-KR")
        let page = URLQueryItem(name: "page", value: "\(currentPage)")
        
        urlComponents.queryItems = [language]
        
        performRequest(with: urlComponents) { [self] data in
            self.totalPage = data.totalPages
            let medium = convertResultToMediaProtocolStruct(data.results)
            completionHandler(medium)
        } errorHandler: { error in
            errorHandler(error)
        }
    }
    
    private func managePage() {
        guard currentPage < totalPage else { return }
        currentPage += 1
    }
    
    private func convertResultToMediaProtocolStruct(_ results: [Result]) -> [MediaProtocol] {
        var medium = [MediaProtocol]()
        
        for result in results {
            guard let mediaType = MediaType(rawValue: result.mediaType) else { continue }
            
            switch mediaType {
            case .movie:
                let movie = Movie(data: result)
                medium.append(movie)
            case .tv:
                let tv = Movie(data: result)
                medium.append(tv)
            }
        }
        
        return medium
    }
    
    private func performRequest(with urlComponents: URLComponents,
                                completionHandler: @escaping (TMDBData) -> (),
                                errorHandler: @escaping (TMDBAPINetworkError) -> ()) {
        
        guard let url = urlComponents.url else {
            print("잘못된 url입니다.")
            return
        }
        
        let session = URLSession.shared
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = HTTPMethod.get.string
        request.allHTTPHeaderFields = headers

        let task = session.dataTask(with: request) { [self] (data, _, error) in
            guard error == nil, let data else {
                errorHandler(.requestError)
                print(error!.localizedDescription)
                return
            }
            
            guard let tmdbData = parseJSON(data) else {
                errorHandler(.dataParsingError)
                return
            }
            
            completionHandler(tmdbData)
        }

        task.resume()
    }
    
    private func parseJSON(_ jsonData: Data) -> TMDBData? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        do {
            let decodedData = try decoder.decode(TMDBData.self, from: jsonData)
            return decodedData
        } catch {
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

