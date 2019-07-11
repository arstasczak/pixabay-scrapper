//
//  SubCoordinator.swift
//  PixabayScrapper
//
//  Created by Arkadiusz Staśczak on 11/07/2019.
//  Copyright © 2019 Arkadiusz Staśczak. All rights reserved.
//

import UIKit

protocol CoordinatorProtocol {
    var navigationController: UINavigationController { get }
    var imageScrapper : ImageScrapperCoordinator { get }
    var videoScrapper : VideoScrapperCoordinator { get }
    init(navigationController: UINavigationController, dependencies: Dependencies)
    func main()
}
class SubCoordinator {
    var navigationController: UINavigationController
    var dependencies: Dependencies
    
    init(navigationController: UINavigationController, dependencies: Dependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
}
