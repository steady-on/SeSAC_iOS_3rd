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
    
    func getTrendAllRanking(completionHandler: @escaping ([MediaProtocol]) -> ()) {
        let genreFetcher = DispatchWorkItem() {
            self.fetchGenreData(for: .movie)
            self.fetchGenreData(for: .tv)
        }
        
        let trendFetcher = DispatchWorkItem() {
            self.fetchTrendingAllData(for: nil, completionHandler: completionHandler)
        }
        
        if Movie.genreDictionary != nil && Tv.genreDictionary != nil {
            genreFetcher.cancel()
        }
        
        genreFetcher.notify(queue: DispatchQueue.global(), execute: trendFetcher)
        
        DispatchQueue.global().async(execute: genreFetcher)
    }
    
    private func fetchTrendingAllData(for mediaType: MediaType?, timeWindow: URLManager.TimeWindow = .day, completionHandler: @escaping ([MediaProtocol]) -> ()) {
        guard var urlComponents = URLComponents(string: URLManager.trending(mediaType: mediaType).url) else { return }
        
        urlComponents.queryItems = [language]
        
        performRequest(to: urlComponents) { (trendData: AllTrendData) in
            let results = trendData.results
            let mediaList = self.convertResultToMediaProtocolStruct(results)
            DispatchQueue.main.async {
                completionHandler(mediaList)
            }
        }
    }
    
    private func convertResultToMediaProtocolStruct(_ results: [Result]) -> [MediaProtocol] {
        var mediaList = [MediaProtocol?]()
        
        for result in results {
            guard let mediaType = MediaType(rawValue: result.mediaType) else { continue }
            switch mediaType {
            case .movie:
                let movie = Movie(data: result)
                mediaList.append(movie)
            case .tv:
                let tv = Tv(data: result)
                mediaList.append(tv)
            }
        }
        
        return mediaList.compactMap { $0 }
    }
    
    private func fetchGenreData(for mediaType: MediaType) {
        guard var urlComponents = URLComponents(string: URLManager.genre(mediaType: mediaType).url) else { return }

        urlComponents.queryItems = [language]
        
        performRequest(to: urlComponents) { (genreData: GenreData) in
            let genres = genreData.genres
            
            switch mediaType {
            case .movie:
                var movieGenres = [Int:String]()
                genres.forEach { genre in movieGenres[genre.id] = genre.name }
                Movie.genreDictionary = movieGenres
            case .tv:
                var tvGenres = [Int:String]()
                genres.forEach { genre in tvGenres[genre.id] = genre.name }
                Tv.genreDictionary = tvGenres
            }
        }
    }
    
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
//        decoder.keyDecodingStrategy = .convertFromSnakeCase
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
