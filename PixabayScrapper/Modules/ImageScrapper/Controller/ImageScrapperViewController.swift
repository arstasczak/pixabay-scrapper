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
    private let dependencies: Dependencies
    
    var searchQuery = BehaviorRelay<String?>(value: nil)
    var pageNumber: BehaviorRelay<Int>
    private let disposeBag = DisposeBag()

    var imageSelected: ((String) -> Void)?

    // MARK: - Initial methods
    
    init(dependencies: Dependencies) {
        imageScrapperViewModel = ImageScrapperViewModel(dependencies: dependencies)
        imageScrapperView = ImageScrapperView(viewModel: imageScrapperViewModel)
        pageNumber = imageScrapperViewModel.pageNumber
        self.dependencies = dependencies
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
        
        imageScrapperViewModel.scrappedImages.asObservable().subscribe(onNext: { [weak self] _ in
            guard let `self` = self else { return }
            self.imageScrapperView.collectionView.reloadData()
            self.updateUI()
        })
        .disposed(by: disposeBag)
    }
    
    private func getImages(query: String?, pageNumber: Int) {
        guard let query = query else { return }
        RequestManager.shared.getPhotos(query: query, page: pageNumber) { [weak self] (images) in
            guard let `self` = self else { return }
            self.imageScrapperViewModel.scrappedImages.accept(self.imageScrapperViewModel.scrappedImages.value + images)
        }
    }
    
    private func createView() {
        view.addSubview(imageScrapperView)
        imageScrapperView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp_topMargin)
            make.leading.trailing.bottom.equalToSuperview()
        }

        imageScrapperView.searchBar.snp.makeConstraints({ (cm) in
            cm.height.equalTo(44)
        })
        
        imageScrapperView.searchBar.delegate = self
        navigationItem.titleView = imageScrapperView.searchBar
        extendedLayoutIncludesOpaqueBars = true
    }
    
    private func updateUI() {
        imageScrapperView.placeholder.isHidden = imageScrapperViewModel.scrappedImages.value.count > 0
    }
}

extension ImageScrapperViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        imageScrapperViewModel.scrappedImages.accept([])
        guard let searchBarText = searchBar.text else { return }
        searchQuery.accept(searchBarText)
    }
}

