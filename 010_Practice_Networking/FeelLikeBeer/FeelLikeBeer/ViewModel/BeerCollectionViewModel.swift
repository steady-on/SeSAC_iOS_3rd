//
//  BeerCollectionViewModel.swift
//  FeelLikeBeer
//
//  Created by Roen White on 2023/09/24.
//

import Foundation

final class BeerCollectionViewModel {
    let beers: Observable<[Beer]> = Observable([])
    
    var numberOfCount: Int { beers.value.count }
    
    func request() {
        BeerManager.request(type: [Beer].self, api: .beers) { result in
            switch result {
            case .success(let data):
                self.beers.value.append(contentsOf: data)
            case .failure(let failure):
                self.beers.value.removeAll(keepingCapacity: true)
                print(failure)
            }
        }
    }
    
    func requestNextPage() {
        BeerManager.request(type: [Beer].self, api: .nextPage) { result in
            switch result {
            case .success(let data):
                self.beers.value.append(contentsOf: data)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func cellForItem(at indexPath: IndexPath) -> Beer {
        return beers.value[indexPath.item]
    }
}
