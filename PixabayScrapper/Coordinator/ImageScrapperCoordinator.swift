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
        self.rootViewController = imageScrapperController
        rootViewController.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
}
