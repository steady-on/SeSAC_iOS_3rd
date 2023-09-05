//
//  KakaoAPIManager.swift
//  Bookworm
//
//  Created by Roen White on 2023/08/11.
//

import Foundation

enum KakaoQueryItem: String {
    case query
    case size
    case page
    
    static var resultSize = "\(30)"
}

struct KakaoAPIManager {
    private static let urlString = "https://dapi.kakao.com/v3/search/book"
    private static var page = 1
    private static var isEnd = false
    private static var urlComponents: URLComponents?
    
    static func searchBook(query: String, completion: @escaping ([Book]?) -> Void) {
        page = 1
        guard var urlComponents = URLComponents(string: urlString) else { return }

        let query = URLQueryItem(name: KakaoQueryItem.query.rawValue, value: query)
        let size = URLQueryItem(name: KakaoQueryItem.size.rawValue, value: KakaoQueryItem.resultSize)
        urlComponents.queryItems = [query, size]
        
        self.urlComponents = urlComponents
        
        performRequest(with: urlComponents) { books in completion(books) }
    }
    
    static func nextPageFetch(completion: @escaping ([Book]?) -> Void) {
        guard var urlComponents, isEnd == false else { return }
        page += 1
        
        let page = URLQueryItem(name: KakaoQueryItem.page.rawValue, value: "\(page)")
        urlComponents.queryItems?.append(page)
        
        performRequest(with: urlComponents) { books in completion(books) }
    }
    
    private static func performRequest(with urlComponents: URLComponents, completion: @escaping ([Book]?) -> Void) {
        guard let url = urlComponents.url else { return }

        let session = URLSession(configuration: .default)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("KakaoAK \(APIKey.kakaoAPIKey)", forHTTPHeaderField: "Authorization")
        
        let task = session.dataTask(with: request) { (data, _, error) in
            guard error == nil else {
                print(error!)
                completion(nil)
                return
            }
            
            guard let safeData = data, let books = self.parseJSON(safeData) else {
                completion(nil)
                return
            }
            
            completion(books)
        }
        
        task.resume()
    }
    
    private static func parseJSON(_ jsonData: Data) -> [Book]? {
        let decoder = JSONDecoder()

        do {
            let decodedData = try decoder.decode(BookData.self, from: jsonData)
            let bookDatas = decodedData.documents
            isEnd = decodedData.meta.isEnd

            let books = bookDatas.map { data in
                Book(title: data.title, author: data.authors.joined(), overview: data.contents, thumbnail: data.thumbnail)
            }
            
            return books
            
        } catch {
            print("Parsing Failed")
            return nil
        }
    }
}




