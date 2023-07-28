//
//  @UserDefaults.swift
//  PracticeTableView
//
//  Created by Roen White on 2023/07/28.
//

import Foundation

@propertyWrapper
struct TodoStorage {
    private let key: String
    private let defaultValue: [Todo]?

    init(key: String, defaultValue: [Todo]? = nil) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: [Todo]? {
        get {
            guard let data = UserDefaults.standard.data(forKey: key) else { return nil }
            let decodedData = try? PropertyListDecoder().decode([Todo].self, from: data)
            return decodedData
        }
        set {
            let newValue = try? PropertyListEncoder().encode(newValue)
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}
