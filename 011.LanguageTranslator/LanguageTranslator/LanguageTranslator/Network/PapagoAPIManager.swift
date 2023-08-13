//
//  PapagoAPIManager.swift
//  LanguageTranslator
//
//  Created by Roen White on 2023/08/13.
//

import Foundation

struct PapagoAPIManager {
    
    static func translateText(_ text: String, source: SourceLanguageType, target: TargetLanguageType, completion: @escaping (Result) -> Void) {
        guard var urlComponents = URLComponents(string: PapagoAPIEndpoint.translate.requestURL) else { return }
        
        let queryItems = [
            "source": source.expression,
            "target": target.expression,
            "text": text
        ]
        
        urlComponents.queryItems = queryItems.map { (name, value) in
            URLQueryItem(name: name, value: value)
        }
        
        performRequest(with: urlComponents) { (result: TranslationData?) in
            guard let result else { return }
            completion(result.message.result)
        }
    }
    
    static func detectLanguage(_ text: String, completion: @escaping (DetectLangsData) -> Void) {
        guard var urlComponents = URLComponents(string: PapagoAPIEndpoint.detectLangs.requestURL) else { return }
        
        let query = URLQueryItem(name: "query", value: text)
        urlComponents.queryItems = [query]
        
        performRequest(with: urlComponents) { (detectLangsData: DetectLangsData?) in
            guard let detectLangsData else { return }
            completion(detectLangsData)
        }
    }
    
    private static func performRequest<T: Decodable>(with urlComponents: URLComponents, completion: @escaping (T?) -> Void) {
        guard let url = urlComponents.url else { return }
        
        let session = URLSession(configuration: .default)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.setValue("vvHUilbiKM7sQ0sa4yla", forHTTPHeaderField: "X-Naver-Client-Id")
        request.setValue("Nw80UDtQj8", forHTTPHeaderField: "X-Naver-Client-Secret")
        
        let task = session.dataTask(with: request) { (data, _, error ) in
            guard error == nil else {
                print(error!)
                completion(nil)
                return
            }
            
            guard let safeData = data, let decodedData: T = self.parseJSON(safeData) else {
                print(error!)
                completion(nil)
                return
            }
            
            completion(decodedData)
        }
        
        task.resume()
    }
    
    private static func parseJSON<T: Decodable>(_ jsonData: Data) -> T? {
        let decoder = JSONDecoder()

        do {
            let decodedData = try decoder.decode(T.self, from: jsonData)
            return decodedData
        } catch {
            print("Parsing Failed")
            return nil
        }
    }
}
