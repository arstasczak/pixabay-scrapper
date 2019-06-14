//
//  MainViewController.swift
//  PixabayScrapper
//
//  Created by Arkadiusz Staśczak on 04/05/2019.
//  Copyright © 2019 Arkadiusz Staśczak. All rights reserved.
//

import UIKit
import SnapKit

enum MainButtonItem: Int {
    case image = 1
    case video
}

class MainViewController: UIViewController {
    
    var mainViewModel: MainViewModel

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pixabay Scrapper"
        mainViewModel.setupView()
        view.addSubview(mainViewModel.view)
        mainViewModel.view.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp_topMargin)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    init() {
        self.mainViewModel = MainViewModel(mainView: MainView())
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
