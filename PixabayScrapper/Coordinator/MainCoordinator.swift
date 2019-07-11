//
//  MainCoordinator.swift
//  PixabayScrapper
//
//  Created by Arkadiusz Staśczak on 11/07/2019.
//  Copyright © 2019 Arkadiusz Staśczak. All rights reserved.
//

import UIKit

class MainCoordinator: SubCoordinator, CoordinatorProtocol {
    var imageScrapper: ImageScrapperCoordinator
    var videoScrapper: VideoScrapperCoordinator
    
    required override init(navigationController: UINavigationController, dependencies: Dependencies) {
        imageScrapper = ImageScrapperCoordinator(navigationController: navigationController, dependencies: dependencies)
        videoScrapper = VideoScrapperCoordinator(navigationController: navigationController, dependencies: dependencies)
        super.init(navigationController: navigationController, dependencies: dependencies)
    }
    func main() {
        let vc = MainViewController(dependencies: dependencies)
        vc.tileSelected = { menuButtonItem in
            switch menuButtonItem {
            case .image:
                self.imageScrapper.goToImageScrapper()
            case .video:
                self.videoScrapper.goToVideoScrapper()
            }
        }
        
        navigationController.pushViewController(vc, animated: true)
    }
}
