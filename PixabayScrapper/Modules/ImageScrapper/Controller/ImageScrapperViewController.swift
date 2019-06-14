//
//  ImageScrapperViewController.swift
//  PixabayScrapper
//
//  Created by Arkadiusz Staśczak on 04/05/2019.
//  Copyright © 2019 Arkadiusz Staśczak. All rights reserved.
//

import UIKit

class ImageScrapperViewController: UIViewController {

    let imageScrapperViewModel: ImageScrapperViewModel
    private var collectionView: UICollectionView?
    private var searchBar: UISearchBar?
    private var pageNumber: Int = 1
    private var searchQuery: String = ""
    
    var scrappedImages: [ScrappedImageDto] = [] {
        didSet {
            collectionView?.reloadData()
            imageScrapperViewModel.view.placeholder.isHidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(imageScrapperViewModel.view)
        imageScrapperViewModel.view.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp_topMargin)
            make.leading.trailing.bottom.equalToSuperview()
        }
        collectionView = imageScrapperViewModel.view.collectionView
        
        let searchBarView = imageScrapperViewModel.view.searchBar
        searchBarView.delegate = self
        searchBar = searchBarView
        navigationItem.titleView = searchBarView

        
        let collectionView = imageScrapperViewModel.view.collectionView
        collectionView.delegate = self
        collectionView.dataSource = self
        let cellNib = UINib(nibName: "ImageScrapperCell", bundle: Bundle.main)
        collectionView.register(cellNib, forCellWithReuseIdentifier: "imageCell")

    }
    
    init() {
        self.imageScrapperViewModel = ImageScrapperViewModel(imageScrapperView: ImageScrapperView())
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getImages(query: String, pageNumber: Int) {
        RequestManager.shared.getPhotosForKey(query: query, page: pageNumber) { [weak self] (scrappedImages) in
            self?.scrappedImages.append(contentsOf: scrappedImages)
        }
    }
}

extension ImageScrapperViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        scrappedImages.removeAll()
        if let searchBarText = searchBar.text, !searchBarText.isEmpty {
            searchQuery = searchBarText
            getImages(query: searchQuery, pageNumber: pageNumber)
        }
    }
}

extension ImageScrapperViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return scrappedImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as? ImageScrapperCell else {return UICollectionViewCell()}
        cell.configureCell(with: scrappedImages[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = collectionView.contentSize.width
        
        return CGSize(width: screenWidth/3, height: screenWidth/3)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == scrappedImages.count-1 {
            pageNumber += 1
            getImages(query: searchQuery, pageNumber: pageNumber)
        }
    }
}
