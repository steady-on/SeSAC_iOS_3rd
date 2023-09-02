//
//  UnsplashImagePickerViewController.swift
//  Harunstargram
//
//  Created by Roen White on 2023/09/02.
//

import UIKit

class UnsplashImagePickerViewController: BaseViewController {
    
    private var photos = [UnsplashPhoto]()
    
    override func loadView() {
        let view = UnsplashImagePickerView()
        self.view = view
        view.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        UnsplashAPIManager.fetchRandomImage(for: nil) { photos in
            guard let photos else {
                // TODO: collectionView hidden하고, "검색결과가 없습니다."
                return
            }
            
            self.photos = photos
            NotificationCenter.default.post(name: NSNotification.Name("isReloadTiming"), object: nil)
        }
    }
}

extension UnsplashImagePickerViewController: UnsplashImagePickerViewDelegate {
    func numberOfItemsInSectionForCollectionView() -> Int {
        return photos.count
    }
    
    func collectionViewCellForItem(at indexPath: IndexPath) -> String {
        return photos[indexPath.item].urls.thumb
    }
    
    func didSelectCollectionViewCellItem(at indexPath: IndexPath) {
        print(#function)
        // TODO: 사진 편집 화면 present
    }
}
