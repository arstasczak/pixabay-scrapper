//
//  ImageScrapperCoordinator.swift
//  PixabayScrapper
//
//  Created by Arkadiusz Staśczak on 04/05/2019.
//  Copyright © 2019 Arkadiusz Staśczak. All rights reserved.
//

import Foundation
import UIKit

class ImageScrapperCoordinator: SubCoordinator {
    
    var fullImageCoordinator: FullImageViewCoordinator
    
    required override init(navigationController: UINavigationController, dependencies: Dependencies) {
        fullImageCoordinator = FullImageViewCoordinator(navigationController: navigationController, dependencies: dependencies)
        super.init(navigationController: navigationController, dependencies: dependencies)
    }
    
    func goToImageScrapper() {
        let vc = ImageScrapperViewController(dependencies: dependencies)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToFullImageView(imageUrl: String) {
        let fullImageViewController = ImageFullViewController(imageUrl: imageUrl)
        if navigationController.viewControllers.last is ImageFullViewController {
            navigationController.viewControllers.removeLast()
        }
        navigationController.pushViewController(fullImageViewController, animated: true)
    }
}
