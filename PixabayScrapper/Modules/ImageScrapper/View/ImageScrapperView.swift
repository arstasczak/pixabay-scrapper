//
//  ImageScrapperView.swift
//  PixabayScrapper
//
//  Created by Arkadiusz Staśczak on 09/06/2019.
//  Copyright © 2019 Arkadiusz Staśczak. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class ImageScrapperView: PlaceholderView {
    
    let collectionView: UICollectionView = {
        
        let collectionFlowLayout = UICollectionViewFlowLayout.init()
        collectionFlowLayout.scrollDirection = .vertical
        collectionFlowLayout.minimumLineSpacing = 0.0
        collectionFlowLayout.minimumInteritemSpacing = 0.0
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: collectionFlowLayout)
        collectionView.allowsSelection = true
        collectionView.backgroundColor = .lightGray
        return collectionView
    }()
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search..."
        searchBar.searchBarStyle = .prominent
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.sizeToFit()
        return searchBar
    }()
    
    override func setup() {
        super.setup()
        imageView.image = UIImage(named: "images_placeholder")
        titleLabel.text = "Brak danych, proszę wpisać szukaną frazę lub sprawdzić swoje połączenie z internetem."
        self.backgroundColor = MAINCOLOR
        
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints { (cm) in
            cm.leading.trailing.bottom.top.equalToSuperview()
        }
        self.bringSubviewToFront(placeholder)
    }
}
