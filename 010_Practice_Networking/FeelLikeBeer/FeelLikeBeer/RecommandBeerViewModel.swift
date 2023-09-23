//
//  RecommandBeerViewModel.swift
//  FeelLikeBeer
//
//  Created by Roen White on 2023/09/24.
//

import Foundation

final class RecommandBeerViewModel {
    let beerOfToday: Observable<Beer?> = Observable(nil)
    
    func requestRandomBeer() {
        BeerManager.request(type: [Beer].self, api: .random) { result in
            switch result {
            case .success(let data):
                self.beerOfToday.value = data.first
            case .failure(_):
                self.beerOfToday.value = nil
            }
        }
    }
}
