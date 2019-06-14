//
//  MainCoordinator.swift
//  PixabayScrapper
//
//  Created by Arkadiusz Staśczak on 04/05/2019.
//  Copyright © 2019 Arkadiusz Staśczak. All rights reserved.
//

import UIKit

class AppCorrdinator: Coordinator {
    var rootViewController: UIViewController {
        return menuCoordinator.rootViewController
    }

    var menuCoordinator: MainCoordinator! {
        didSet {
            rootViewControllerSwitched()
        }
    }
    var rootViewControllerSwitched: () -> Void = {}
    
    func start() {
        /// ADD CODE TO INSTANSIATE MAIN CONTROLLER
        menuCoordinator = MainCoordinator()
    }
    
}
