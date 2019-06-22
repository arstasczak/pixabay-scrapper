//
//  VideoScrapperViewController.swift
//  PixabayScrapper
//
//  Created by Arkadiusz Staśczak on 04/05/2019.
//  Copyright © 2019 Arkadiusz Staśczak. All rights reserved.
//

import UIKit
import AVKit

class VideoScrapperViewController: UIViewController {
    
    private let videoScrapperViewModel: VideoScrapperViewModel
    private var tableView: UITableView?
    private var searchBar: UISearchBar?
    private var searchQuery: String = ""
    private var pageNumber: Int = 1
    
    private var scrappedVideos: [ScrappedVideoDto] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView?.reloadData()
            }
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = videoScrapperViewModel.view
        tableView = videoScrapperViewModel.view.tableView
        tableView?.delegate = self
        tableView?.dataSource = self
        let cellNib = UINib(nibName: "VideoScrapperCell", bundle: Bundle.main)
        tableView?.register(cellNib, forCellReuseIdentifier: "videoScrapperCell")
        
        let searchBarView = videoScrapperViewModel.view.searchBar
        searchBarView.delegate = self
        searchBar = searchBarView
        searchBar?.snp.makeConstraints({ (cm) in
            cm.height.equalTo(44)
        })
        navigationItem.titleView = searchBarView
        extendedLayoutIncludesOpaqueBars = true
    }
    
    init() {
        self.videoScrapperViewModel = VideoScrapperViewModel(videoScrapperView: VideoScrapperView())
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getVideos(query: String, pageNumber: Int) {
        RequestManager.shared.getVideos(query: query, page: pageNumber) { [weak self] (scrappedVideos) in
            self?.scrappedVideos.append(contentsOf: scrappedVideos)
        }
    }
    
}

extension VideoScrapperViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        scrappedVideos.removeAll()
        if let searchBarText = searchBar.text, !searchBarText.isEmpty {
            searchQuery = searchBarText
            getVideos(query: searchQuery, pageNumber: pageNumber)
        }
    }
}

extension VideoScrapperViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scrappedVideos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "videoScrapperCell", for: indexPath) as? VideoScrapperCell else {
            return UITableViewCell()
        }
        
        cell.configureCell(with: scrappedVideos[indexPath.row])
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedVideo = scrappedVideos[indexPath.row]
        
        guard let videoURLString = selectedVideo.videos.first?.videoURL, let videoURL = URL(string: videoURLString) else {return}
        
        let avPlayer = AVPlayer(url: videoURL)
        let avPlayerController = AVPlayerViewController()
        
        avPlayerController.player = avPlayer
        
        self.present(avPlayerController, animated: true) {
            avPlayer.play()
        }
    }
}
