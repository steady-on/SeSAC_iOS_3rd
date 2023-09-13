//
//  Observable.swift
//  LotteryChecker
//
//  Created by Roen White on 2023/09/13.
//

import Foundation

final class Observable<T> {
    var value: T {
        didSet { completion?(value) }
    }
    
    var completion: ((T) -> Void)?
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(completion: @escaping (T) -> ()) {
        self.completion = completion
    }
}