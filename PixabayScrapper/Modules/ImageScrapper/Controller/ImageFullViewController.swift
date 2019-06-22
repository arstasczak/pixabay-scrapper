//
//  ImageFullViewController.swift
//  PixabayScrapper
//
//  Created by Arkadiusz Staśczak on 15/06/2019.
//  Copyright © 2019 Arkadiusz Staśczak. All rights reserved.
//

import UIKit
import Kingfisher

class ImageFullViewController: UIViewController {
    
    private let selectedImageURL: String

    override func viewDidLoad() {
        super.viewDidLoad()
        let fullImageView = ImageFullView()
        fullImageView.setup(imageURL: selectedImageURL)
        view.backgroundColor = SECCOLOR
        title = "Image Full Screen"
        self.view.addSubview(fullImageView)
        fullImageView.snp.makeConstraints { (cm) in
            cm.top.equalTo(self.view.snp_topMargin)
            cm.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    init(imageUrl: String) {
        self.selectedImageURL = imageUrl
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}