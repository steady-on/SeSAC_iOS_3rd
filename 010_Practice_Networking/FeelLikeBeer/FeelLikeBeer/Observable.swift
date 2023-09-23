//
//  Observable.swift
//  FeelLikeBeer
//
//  Created by Roen White on 2023/09/24.
//

import Foundation

final class Observable<T> {
    var value: T {
        didSet { listener?(value) }
    }
    
    private var listener: ((T) -> Void)?
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(closure: @escaping (T) -> Void) {
        closure(value)
        self.listener = closure
    }
}
