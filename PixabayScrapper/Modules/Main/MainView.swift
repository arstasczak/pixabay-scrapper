//
//  MainView.swift
//  PixabayScrapper
//
//  Created by Arkadiusz Staśczak on 04/05/2019.
//  Copyright © 2019 Arkadiusz Staśczak. All rights reserved.
//

import UIKit
import SnapKit

class MainView: UIView {
    
    let imageButton: UIButton = {
        let button = UIButton()
        button.setTitle("Image scrapper", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.lightGray, for: .selected)
        button.backgroundColor = MAINCOLOR
        button.tag = 1
        button.addShadow()
        return button
    }()
    
    let videoButton: UIButton = {
        let button = UIButton()
        button.setTitle("Video scrapper", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.lightGray, for: .selected)
        button.backgroundColor = MAINCOLOR
        button.tag = 2
        button.addShadow()
        return button
    }()
    
    func setup() {
        self.backgroundColor = UIColor(red: 235, green: 235, blue: 235, alpha: 1)
        createTilesView()
    }

    private func createTilesView() {

        self.addSubview(imageButton)
        imageButton.snp.makeConstraints { (make) in
            make.height.equalTo(150)
            make.width.equalTo(250)
            make.top.equalToSuperview().offset(50)
            make.centerX.equalToSuperview()
        }
        
        self.addSubview(videoButton)
        videoButton.snp.makeConstraints { (make) in
            make.height.equalTo(imageButton.snp.height)
            make.width.equalTo(imageButton.snp.width)
            make.top.equalTo(imageButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }

    }
}

extension UIButton {
    func addShadow() {
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 2
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOpacity = 1.0
        self.layer.masksToBounds = false
    }
}
