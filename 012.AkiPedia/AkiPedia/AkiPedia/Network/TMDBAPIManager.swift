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
    
    private var genreForMovie = [Int: String]()
    private var genreForTV = [Int: String]()
    
    private func fetchGenreData(for mediaType: MediaType) {
        guard var urlComponents = URLComponents(string: TMDBEndpoint.genre(mediaType: mediaType).url) else { return }
        
        let language = URLQueryItem(name: "language", value: "ko")
        urlComponents.queryItems = [language]
        
        performRequest(with: urlComponents) { (genres: [Genre]) in
            switch mediaType {
            case .movie:
                genres.forEach { genre in
                    self.genreForMovie[genre.id] = genre.name
                }
            case .tv:
                genres.forEach { genre in
                    self.genreForTV[genre.id] = genre.name
                }
            }
        } errorHandler: { error in
            print(error)
        }
    }
    
    private func fetchTrendingAllData(pageUp: Bool = false, completionHandler: @escaping ([MediaProtocol]) -> Void,
                              errorHandler: @escaping (TMDBAPINetworkError) -> Void) {
        guard var urlComponents = URLComponents(string: TMDBEndpoint.trending(mediaType: nil).url) else { return }
        
        if pageUp { managePage() }
        
        let language = URLQueryItem(name: "language", value: "ko-KR")
        let page = URLQueryItem(name: "page", value: "\(currentPage)")
        
        urlComponents.queryItems = [language]
        
        performRequest(with: urlComponents) { [self] (data: TMDBData) in
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
                let id = result.id
                let title = result.title ?? ""
                let originalTitle = result.originalTitle ?? ""
                let originalLanguage = result.originalLanguage
                let releaseDate = result.releaseDate ?? ""
                let genre = result.genreIDS.map { genreForMovie[$0, default: ""] }
                let backdropPath = result.backdropPath
                let posterPath = result.posterPath
                let popularity = result.popularity
                let adult = result.adult
                let voteCount = result.voteCount
                let voteAverage = result.voteAverage
                let overview = result.overview
                let video = result.video ?? false
                
                let movie = Movie(id: id, title: title, originalTitle: originalTitle, originalLanguage: originalLanguage, releaseDate: releaseDate, genre: genre, backdropPath: backdropPath, posterPath: posterPath, popularity: popularity, adult: adult, voteCount: voteCount, voteAverage: voteAverage, overview: overview, video: video)
                medium.append(movie)
            case .tv:
                let id = result.id
                let name = result.name ?? ""
                let originalName = result.originalName ?? ""
                let originalLanguage = result.originalLanguage
                let originCountry = result.originCountry ?? [String]()
                let firstAirDate = result.firstAirDate ?? ""
                let genre = result.genreIDS.map { genreForTV[$0, default: ""] }
                let backdropPath = result.backdropPath
                let posterPath = result.posterPath
                let popularity = result.popularity
                let adult = result.adult
                let voteCount = result.voteCount
                let voteAverage = result.voteAverage
                let overview = result.overview
                
                let tv = TV(id: id, name: name, originalName: originalName, originalLanguage: originalLanguage, originCountry: originCountry, firstAirDate: firstAirDate, genre: genre, backdropPath: backdropPath, posterPath: posterPath, popularity: popularity, adult: adult, voteCount: voteCount, voteAverage: voteAverage, overview: overview)
                medium.append(tv)
            }
        }
        
        return medium
    }
    
    private func performRequest<T:Decodable>(with urlComponents: URLComponents,
                                completionHandler: @escaping (T) -> (),
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
            
            guard let decodedData: T = parseJSON(data) else {
                errorHandler(.dataParsingError)
                return
            }
            
            completionHandler(decodedData)
        }

        task.resume()
    }
    
    private func parseJSON<T:Decodable>(_ jsonData: Data) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        do {
            let decodedData = try decoder.decode(T.self, from: jsonData)
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

