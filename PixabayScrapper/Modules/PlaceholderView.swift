//
//  PlaceholderView.swift
//  PixabayScrapper
//
//  Created by Arkadiusz Staśczak on 14/06/2019.
//  Copyright © 2019 Arkadiusz Staśczak. All rights reserved.
//

import UIKit
import SnapKit

class PlaceholderView: UIView {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = MAINCOLOR
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let placeholder = UIView()
    
    func setup() {
        self.addSubview(placeholder)
        placeholder.backgroundColor = SECCOLOR
        placeholder.snp.makeConstraints { (cm) in
            cm.leading.trailing.top.bottom.equalToSuperview()
        }
        placeholder.addSubview(imageView)
        imageView.snp.makeConstraints { (cm) in
            cm.centerX.equalToSuperview()
            cm.centerY.equalToSuperview().offset(-50)
            cm.width.height.equalTo(150)
        }
        
        placeholder.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (cm) in
            cm.centerX.equalToSuperview()
            cm.top.equalTo(imageView.snp_bottomMargin).offset(30)
            cm.width.equalTo(250)
        }
    }
}
