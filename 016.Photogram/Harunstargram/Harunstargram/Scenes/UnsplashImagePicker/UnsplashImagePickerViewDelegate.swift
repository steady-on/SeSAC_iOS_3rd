//
//  HomeViewDelegate.swift
//  Harunstargram
//
//  Created by Roen White on 2023/09/01.
//

import Foundation

protocol UnsplashImagePickerViewDelegate: AnyObject {
    func numberOfItemsInSectionForCollectionView() -> Int
    func collectionViewCellForItem(at indexPath: IndexPath) -> String
    func didSelectCollectionViewCellItem(at indexPath: IndexPath)
}
