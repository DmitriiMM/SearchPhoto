//
//  CollectionViewController.swift
//  WhiteAndFluffyTest
//
//  Created by Дмитрий Мартынов on 29.01.2022.
//

import UIKit

class CollectionViewController: UIViewController {
    
    // MARK: - Properties:
    private var photos: [String : UIImageView] = ["mary" : UIImageView(image: UIImage(named: "mary")),
                                                  "lagut" : UIImageView(image: UIImage(named: "lagut")),
                                                  "tambi" : UIImageView(image: UIImage(named: "tambi")),
                                                  "kama" : UIImageView(image: UIImage(named: "kama")),
    ]
    
    private var filteredPhotos: [UIImageView] = []
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.itemSize = CGSize(width: (view.frame.width / 3) - 1,
                                 height: (view.frame.width / 3) - 1)
        let collection = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let imageToLoad = selectedImage?.photo {
            imageView.image = imageToLoad
        }
        
        func setupSearchBar() {
            searchController.searchResultsUpdater = self
            searchController.obscuresBackgroundDuringPresentation = false
            searchController.searchBar.placeholder = "Search"
            navigationItem.searchController = searchController
        }
        
        func setupCollectionView() {
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifire)
            
            view.addSubview(collectionView)
        }
        
        func makeConstraints() {
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        }
        
        setupSearchBar()
        setupCollectionView()
        makeConstraints()
    }
}

extension CollectionViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterPhotoForSearchText(searchText: searchController.searchBar.text!)
    }
    
    private func filterPhotoForSearchText(searchText: String) {
        filteredPhotos = Array(photos
                                .filter({ $0.key.lowercased().contains(searchText.lowercased()) })
                                .values
        )
        collectionView.reloadData()
    }
    
}

extension CollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFiltering {
            return filteredPhotos.count
        }
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifire, for: indexPath) as! CollectionViewCell
        
        var searchedPhoto = UIImageView()
        if isFiltering {
            searchedPhoto = filteredPhotos[indexPath.row]
        } else {
            searchedPhoto = Array(photos.values)[indexPath.row]
        }
        
        cell.imageView.image = searchedPhoto.image
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let vc = DetailViewController()
        
        vc.selectedImage = photos[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
