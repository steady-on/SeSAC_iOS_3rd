//
//  UnsplashAPIManager.swift
//  Harunstargram
//
//  Created by Roen White on 2023/09/01.
//

import Foundation

final class UnsplashAPIManager {
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
