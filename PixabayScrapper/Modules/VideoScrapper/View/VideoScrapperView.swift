//
//  VideoScrapperView.swift
//  PixabayScrapper
//
//  Created by Arkadiusz Staśczak on 16/06/2019.
//  Copyright © 2019 Arkadiusz Staśczak. All rights reserved.
//

import UIKit

class VideoScrapperView: PlaceholderView {
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.allowsMultipleSelection = false
        tableView.tableFooterView = UIView()
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
