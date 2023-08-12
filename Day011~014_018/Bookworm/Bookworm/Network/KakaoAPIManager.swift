//
//  KakaoAPIManager.swift
//  Bookworm
//
//  Created by Roen White on 2023/08/11.
//

import Foundation

struct KakaoAPIManager {
    private static let urlString = "https://dapi.kakao.com/v3/search/book"
    
    static func searchBook(query: String, completion: @escaping ([Book]?) -> Void) {
        guard var urlComponents = URLComponents(string: urlString) else { return }

        let paramaters = URLQueryItem(name: "query", value: query)
        urlComponents.queryItems = [paramaters]
        
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
            
            let books = bookDatas.map { data in
                Book(title: data.title, author: data.authors.joined(), introduce: data.contents, thumbnail: data.thumbnail)
            }
            
            return books
            
        } catch {
            print("Parsing Failed")
            return nil
        }
    }
}




