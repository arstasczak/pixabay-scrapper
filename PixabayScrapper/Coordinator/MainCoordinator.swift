//
//  MainCoordinator.swift
//  PixabayScrapper
//
//  Created by Arkadiusz Staśczak on 04/05/2019.
//  Copyright © 2019 Arkadiusz Staśczak. All rights reserved.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {

    var navigationController: UINavigationController
    
    var rootViewController: UIViewController {
        return navigationController
    }
    
    private lazy var imageScrapperCoordinatror : ImageScrapperCoordinator = {
        return ImageScrapperCoordinator()
    }()
    
    private lazy var videoScrapperCoordinator : VideoScrapperCoordinator = {
        return VideoScrapperCoordinator()
    }()
    
    init() {
        let mainController = MainViewController()
        navigationController = NavigationController(rootViewController: mainController)
        mainController.mainViewModel.tileSelected = { [weak self] buttonItem in
            guard let self = self else { return }
            switch buttonItem {
            case .image:
                self.navigationController.pushViewController(self.imageScrapperCoordinatror.rootViewController, animated: true)
            case .video:
                self.navigationController.pushViewController(self.videoScrapperCoordinator.rootViewController, animated: true)
            }
        }
        self.navigationController.setNavigationBarHidden(false, animated: false)
    }
    
    class NavigationController: UINavigationController {
        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            viewController.navigationItem.backBarButtonItem =
                UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            super.pushViewController(viewController, animated: animated)
        }
    }
}
