//
//  ImageScrapperViewController.swift
//  PixabayScrapper
//
//  Created by Arkadiusz Staśczak on 04/05/2019.
//  Copyright © 2019 Arkadiusz Staśczak. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ImageScrapperViewController: UIViewController {

    private let imageScrapperViewModel: ImageScrapperViewModel
    private let imageScrapperView: ImageScrapperView

    private var searchQuery = BehaviorRelay<String>(value: "")
    private var pageNumber =  BehaviorRelay<Int>(value: 1)
    private var scrappedImages = BehaviorRelay<[ScrappedImageDto]>(value: [])
    private let disposeBag = DisposeBag()

    var imageSelected: ((String) -> Void)?

    // MARK: - Initial methods
    
    init() {
        self.imageScrapperViewModel = ImageScrapperViewModel()
        self.imageScrapperView = ImageScrapperView(viewModel: imageScrapperViewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observeProperties()
        createView()
    }
    
    // MARK: - Private methods

    private func observeProperties() {
        pageNumber.subscribe(onNext: { [weak self] (pageNumber) in
            guard let `self` = self else { return }
            self.getImages(query: self.searchQuery.value, pageNumber: pageNumber)
        })
        .disposed(by: disposeBag)
        
        searchQuery.subscribe(onNext: { [weak self] (query) in
            guard let `self` = self else { return }
            self.getImages(query: query, pageNumber: self.pageNumber.value)
        })
        .disposed(by: disposeBag)
        
        scrappedImages.asObservable().subscribe(onNext: { [weak self] _ in
            guard let `self` = self else { return }
            self.imageScrapperView.collectionView.reloadData()
            self.updateUI()
        })
        .disposed(by: disposeBag)
    }
    
    private func createView() {
        view.addSubview(imageScrapperView)
        imageScrapperView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp_topMargin)
            make.leading.trailing.bottom.equalToSuperview()
        }

        imageScrapperView.collectionView.delegate = self
        imageScrapperView.collectionView.dataSource = self

        imageScrapperView.searchBar.delegate = self
        imageScrapperView.searchBar.snp.makeConstraints({ (cm) in
            cm.height.equalTo(44)
        })
        navigationItem.titleView = imageScrapperView.searchBar
        extendedLayoutIncludesOpaqueBars = true
    }
    
    private func updateUI() {
        imageScrapperView.placeholder.isHidden = scrappedImages.value.count > 0
    }
    
    private func getImages(query: String, pageNumber: Int) {
        RequestManager.shared.getPhotos(query: query, page: pageNumber) { [weak self] (images) in
            guard let `self` = self else { return }
            self.scrappedImages.accept(self.scrappedImages.value + images)
        }
    }
}

extension ImageScrapperViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        scrappedImages.accept([])
        guard let searchBarText = searchBar.text else { return }
        searchQuery.accept(searchBarText)
    }
}

extension ImageScrapperViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
        if indexPath.row == scrappedImages.value.count-1 {
            pageNumber.accept(pageNumber.value + 1)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItem = scrappedImages.value[indexPath.row]
        imageSelected?(selectedItem.imageURL)
    }
}
