//
//  VideoScrapperViewController.swift
//  PixabayScrapper
//
//  Created by Arkadiusz Staśczak on 04/05/2019.
//  Copyright © 2019 Arkadiusz Staśczak. All rights reserved.
//

import UIKit
import AVKit
import RxSwift
import RxCocoa

class VideoScrapperViewController: UIViewController {
    
    private let videoScrapperViewModel: VideoScrapperViewModel
    private let videoScrapperView: VideoScrapperView
    private let dependencies: Dependencies
    
    private var tableView: UITableView?
    private var searchBar: UISearchBar?
    
    private let disposeBag = DisposeBag()
    private var scrappedVideos = BehaviorRelay<[ScrappedVideoDto]>(value: [])
    private var searchQuery = BehaviorRelay<String?>(value: nil)
    private var pageNumber = BehaviorRelay<Int>(value: 1)
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        self.videoScrapperViewModel = VideoScrapperViewModel(dependencies: dependencies)
        self.videoScrapperView = VideoScrapperView(viewModel: videoScrapperViewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    deinit {
        print("deinit called")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        createView()
        setupObservables()
    }

    private func setupObservables() {
        scrappedVideos.subscribe(onNext: { [weak self] _ in
            guard let `self` = self else { return }
            if self.scrappedVideos.value.count > 0 {
                self.videoScrapperView.placeholder.isHidden = true
            }
            self.videoScrapperView.tableView.reloadData()
        })
        .disposed(by: disposeBag)
        
        searchQuery.subscribe(onNext: { [weak self] (searchQuery) in
            guard let `self` = self else { return }
            self.getVideos(query: searchQuery, pageNumber: self.pageNumber.value)
        })
        .disposed(by: disposeBag)
        
        pageNumber.subscribe(onNext: { [weak self] (pageNumber) in
            guard let `self` = self else { return }
            self.getVideos(query: self.searchQuery.value, pageNumber: pageNumber)
        })
        .disposed(by: disposeBag)
    }
    
    private func createView() {
        self.view.addSubview(videoScrapperView)
        videoScrapperView.snp.makeConstraints { (cm) in
            cm.top.equalTo(self.view.snp_topMargin)
            cm.leading.trailing.bottom.equalToSuperview()
        }
        videoScrapperView.tableView.delegate = self
        videoScrapperView.tableView.dataSource = self
        
        videoScrapperView.searchBar.delegate = self
        videoScrapperView.searchBar.snp.makeConstraints({ (cm) in
            cm.height.equalTo(44)
        })
        navigationItem.titleView = videoScrapperView.searchBar
        extendedLayoutIncludesOpaqueBars = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getVideos(query: String?, pageNumber: Int) {
        guard let query = query else { return }
        RequestManager.shared.getVideos(query: query, page: pageNumber) { [weak self] (videos) in
            guard let `self` = self else { return }
            self.scrappedVideos.accept(self.scrappedVideos.value + videos)
        }
    }
}

extension VideoScrapperViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        scrappedVideos.accept([])
        if let searchBarText = searchBar.text, !searchBarText.isEmpty {
            searchQuery.accept(searchBarText)
        }
    }
}

extension VideoScrapperViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scrappedVideos.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "videoScrapperCell", for: indexPath) as? VideoScrapperCell else {
            return UITableViewCell()
        }
        
        cell.configureCell(with: scrappedVideos.value[indexPath.row])
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedVideo = scrappedVideos.value[indexPath.row]
        
        guard let videoURLString = selectedVideo.videos.first?.videoURL, let videoURL = URL(string: videoURLString) else {return}
        
        let avPlayer = AVPlayer(url: videoURL)
        let avPlayerController = AVPlayerViewController()
        
        avPlayerController.player = avPlayer
        
        self.present(avPlayerController, animated: true) {
            avPlayer.play()
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == scrappedVideos.value.count - 1 && scrappedVideos.value.count == pageNumber.value * 15 {
            pageNumber.accept(pageNumber.value + 1)
        }
    }
}

