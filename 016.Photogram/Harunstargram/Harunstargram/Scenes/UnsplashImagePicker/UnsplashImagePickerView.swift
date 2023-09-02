//
//  UnsplashImagePickerView.swift
//  Harunstargram
//
//  Created by Roen White on 2023/09/01.
//

import UIKit

class UnsplashImagePickerView: BaseView {
    
    weak var delegate: UnsplashImagePickerViewDelegate?
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "검색어를 입력하세요"
        searchBar.searchTextField.clearButtonMode = .always
        searchBar.delegate = self
        return searchBar
    }()
    
    lazy var imageCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: setCollectionViewLayout())
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        return collectionView
    }()
    
    override func configureView() {
        super.configureView()
        
        let components = [searchBar, imageCollectionView]
        components.forEach { component in
            addSubview(component)
            component.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    override func setConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            imageCollectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            imageCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            imageCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            imageCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let width = UIScreen.main.bounds.width
        layout.itemSize = .init(width: width/3, height: width/3)
        
        return layout
    }
}

extension UnsplashImagePickerView: UISearchBarDelegate {
    
}

extension UnsplashImagePickerView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let number = delegate?.numberOfItemsInSectionForCollectionView() else { return 0 }
        return number
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as? ImageCollectionViewCell else { return UICollectionViewCell() }
        
        guard let imageUrl = delegate?.collectionViewCellForItem(at: indexPath) else { return cell }
        
        cell.imageView.getDataFromUrl(url: imageUrl)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectCollectionViewCellItem(at: indexPath)
    }
}
