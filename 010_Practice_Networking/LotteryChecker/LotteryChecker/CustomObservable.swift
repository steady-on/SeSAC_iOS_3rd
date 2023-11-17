//
//  CustomObservable.swift
//  LotteryChecker
//
//  Created by Roen White on 2023/09/13.
//

import Foundation

final class CustomObservable<T> {
    var value: T {
        didSet { listener?(value) }
    }
    
    var listener: ((T) -> Void)?
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(completion: @escaping (T) -> ()) {
        completion(value)
        self.listener = completion
    }
}
