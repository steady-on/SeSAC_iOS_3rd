//
//  @UserDefaults.swift
//  PracticeTableView
//
//  Created by Roen White on 2023/07/28.
//

import Foundation

@propertyWrapper
struct UserDefault<T: Encodable> {
    private let key: String
    private let defaultValue: T

    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}
