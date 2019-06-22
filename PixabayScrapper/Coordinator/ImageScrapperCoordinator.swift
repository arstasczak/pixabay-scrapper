//
//  ImageScrapperCoordinator.swift
//  PixabayScrapper
//
//  Created by Arkadiusz Staśczak on 04/05/2019.
//  Copyright © 2019 Arkadiusz Staśczak. All rights reserved.
//

import Foundation
import UIKit

class ImageScrapperCoordinator: Coordinator {
    var rootViewController: UIViewController
    
    init() {
        let imageScrapperController = ImageScrapperViewController()
        rootViewController = imageScrapperController
        imageScrapperController.imageSelected = { [weak self] imageURL in
            self?.goToFullImageView(imageUrl: imageURL)
        }
        rootViewController.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func goToFullImageView(imageUrl: String) {
        let fullImageViewController = ImageFullViewController(imageUrl: imageUrl)
        rootViewController.navigationController?.pushViewController(fullImageViewController, animated: true)
    }
}
