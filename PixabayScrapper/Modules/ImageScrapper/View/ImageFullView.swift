//
//  ImageFullView.swift
//  PixabayScrapper
//
//  Created by Arkadiusz Staśczak on 15/06/2019.
//  Copyright © 2019 Arkadiusz Staśczak. All rights reserved.
//

import UIKit
import Kingfisher

class ImageFullView: UIView {
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    func setup() {
        self.backgroundColor = SECCOLOR
        self.addSubview(imageView)
        imageView.snp.makeConstraints { (cm) in
            cm.bottom.top.leading.trailing.equalToSuperview()
        }
    }
}
