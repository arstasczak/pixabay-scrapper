//
//  VideoScrapperCoordinator.swift
//  PixabayScrapper
//
//  Created by Arkadiusz Staśczak on 04/05/2019.
//  Copyright © 2019 Arkadiusz Staśczak. All rights reserved.
//

import Foundation
import UIKit

class VideoScrapperCoordinator: Coordinator {
    var rootViewController: UIViewController

    init() {
        let videoScrapperController = VideoScrapperViewController()
        self.rootViewController = videoScrapperController
        rootViewController.navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
