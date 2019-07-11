//
//  VideoScrapperView.swift
//  PixabayScrapper
//
//  Created by Arkadiusz Staśczak on 16/06/2019.
//  Copyright © 2019 Arkadiusz Staśczak. All rights reserved.
//

import UIKit

class VideoScrapperView: PlaceholderView {
    
    private var viewModel: VideoScrapperViewModel

    init(viewModel: VideoScrapperViewModel) {
        self.viewModel = viewModel
        super.init(frame: CGRect.zero)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.allowsMultipleSelection = false
        tableView.tableFooterView = UIView()
        let cellNib = UINib(nibName: "VideoScrapperCell", bundle: Bundle.main)
        tableView.register(cellNib, forCellReuseIdentifier: "videoScrapperCell")
        return tableView
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
        
        self.addSubview(tableView)
        tableView.snp.makeConstraints { (cm) in
            cm.top.bottom.leading.trailing.equalToSuperview()
        }
        self.bringSubviewToFront(placeholder)
    }
}
