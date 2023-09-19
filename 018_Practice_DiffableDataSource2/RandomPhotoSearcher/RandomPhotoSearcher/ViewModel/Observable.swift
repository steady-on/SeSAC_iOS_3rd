//
//  Observable.swift
//  RandomPhotoSearcher
//
//  Created by Roen White on 2023/09/19.
//

import Foundation

final class Observable<T> {
    var value: T {
        didSet { listener?(value) }
    }
    
    private var listener: ((T) -> Void)?
    
    init(value: T) {
        self.value = value
    }
    
    func bind(listener: @escaping (T) -> Void) {
        listener(value)
        self.listener = listener
    }
}
