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
    
    private var mainViewModel: MainViewModel
    private var mainView: MainView
    private let dependencies: Dependencies
    var tileSelected: ((MainButtonItem) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pixabay Scrapper"
        createView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        title = ""
    }
    
    func createView() {
        view.addSubview(mainView)
        mainView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp_topMargin)
            make.leading.trailing.bottom.equalToSuperview()
        }
        setupViewTargets()
    }
    
    func setupViewTargets() {
        mainView.imageButton.addTarget(self, action: #selector(tileClicked(_:)), for: .touchUpInside)
        mainView.videoButton.addTarget(self, action: #selector(tileClicked(_:)), for: .touchUpInside)
    }
    
    @objc func tileClicked(_ sender: UIControl) {
        guard let tile = MainButtonItem(rawValue: sender.tag) else { return }
        tileSelected?(tile)
    }

    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        self.mainViewModel = MainViewModel(mainView: MainView())
        self.mainView = MainView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
