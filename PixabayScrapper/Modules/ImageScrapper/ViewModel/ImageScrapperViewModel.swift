//
//  ImageScrapperViewModel.swift
//  PixabayScrapper
//
//  Created by Arkadiusz Staśczak on 09/06/2019.
//  Copyright © 2019 Arkadiusz Staśczak. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ImageScrapperViewModel: HasDependencies {
    var scrappedImages = BehaviorRelay<[ScrappedImageDto]>(value: [])
    var pageNumber =  BehaviorRelay<Int>(value: 1)
    
    required init(dependencies: Dependencies) {
        super.init(dependencies: dependencies)
    }
}

extension ImageScrapperViewModel: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return scrappedImages.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as? ImageScrapperCell else {return UICollectionViewCell()}
        cell.configureCell(with: scrappedImages.value[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = collectionView.contentSize.width
        
        return CGSize(width: screenWidth/3, height: screenWidth/3)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == scrappedImages.value.count-1 && scrappedImages.value.count == pageNumber.value * 20 {
            pageNumber.accept(pageNumber.value + 1)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        dependencies.coordinator.imageScrapper.fullImageCoordinator.fullImage(imageUrl: scrappedImages.value[indexPath.row].imageURL)
    }
}
