//
//  PhotoViewModel.swift
//  RandomPhotoSearcher
//
//  Created by Roen White on 2023/09/19.
//

import Foundation

final class PhotoViewModel {
    let unsplashPhotos = Observable(value: [UnsplashPhoto]())
    
    func fetchRandomImage(for query: String?) {
        UnsplashAPIManager.fetchRandomImage(for: query) { [weak self] result in
            guard let result else {
                self?.unsplashPhotos.value = []
                return
            }
            
            self?.unsplashPhotos.value = result
        }
    }
}
