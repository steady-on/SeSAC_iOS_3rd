//
//  UnsplashImagePickerViewController.swift
//  Harunstargram
//
//  Created by Roen White on 2023/09/02.
//

import UIKit

class UnsplashImagePickerViewController: BaseViewController {
    
    private var mainView: UnsplashImagePickerView!
    
    private var photos = [UnsplashPhoto]() {
        didSet { imageCollectionView.reloadData() }
    }
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "검색어를 입력하세요"
        searchBar.searchTextField.clearButtonMode = .always
        searchBar.delegate = self
        return searchBar
    }()
    
    private lazy var imageCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: setCollectionViewLayout())
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        return collectionView
    }()
    
    private let indicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView()
        indicatorView.hidesWhenStopped = true
        indicatorView.style = .large
        return indicatorView
    }()
    
    private let indicatorBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray.withAlphaComponent(0.5)
        view.isHidden = true
        return view
    }()
    
    override func loadView() {
        mainView = UnsplashImagePickerView()
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchImageToUnsplash()
    }
    
    override func configureView() {
        mainView.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        mainView.addSubview(imageCollectionView)
        imageCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        mainView.addSubview(indicatorBackgroundView)
        indicatorBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        mainView.addSubview(indicatorView)
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func setConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: mainView.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: mainView.safeAreaLayoutGuide.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: mainView.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            imageCollectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            imageCollectionView.leadingAnchor.constraint(equalTo: mainView.safeAreaLayoutGuide.leadingAnchor),
            imageCollectionView.trailingAnchor.constraint(equalTo: mainView.safeAreaLayoutGuide.trailingAnchor),
            imageCollectionView.bottomAnchor.constraint(equalTo: mainView.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            indicatorBackgroundView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            indicatorBackgroundView.leadingAnchor.constraint(equalTo: mainView.safeAreaLayoutGuide.leadingAnchor),
            indicatorBackgroundView.trailingAnchor.constraint(equalTo: mainView.safeAreaLayoutGuide.trailingAnchor),
            indicatorBackgroundView.bottomAnchor.constraint(equalTo: mainView.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            indicatorView.centerXAnchor.constraint(equalTo: mainView.safeAreaLayoutGuide.centerXAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: mainView.safeAreaLayoutGuide.centerYAnchor)
        ])
    }
    
    private func fetchImageToUnsplash(for query: String? = nil) {
        indicatorBackgroundView.isHidden = false
        indicatorView.startAnimating()
        
        UnsplashAPIManager.fetchRandomImage(for: query) { photos in
            guard let photos else {
                DispatchQueue.main.async {
                    self.photos = []
                    self.imageCollectionView.isHidden = true
                    
                    self.indicatorBackgroundView.isHidden.toggle()
                    self.indicatorView.stopAnimating()
                }
                return
            }

            self.photos = photos
            self.imageCollectionView.isHidden = false
            
            self.indicatorBackgroundView.isHidden.toggle()
            self.indicatorView.stopAnimating()
        }
    }
}

extension UnsplashImagePickerViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        fetchImageToUnsplash(for: searchBar.text)
    }
}

extension UnsplashImagePickerViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    private func setCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let width = UIScreen.main.bounds.width
        layout.itemSize = .init(width: width/3, height: width/3)
        
        return layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as? ImageCollectionViewCell else { return UICollectionViewCell() }
        
        let data = photos[indexPath.item].urls.thumb
        cell.imageView.getDataFromUrl(url: data)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
    }
}
