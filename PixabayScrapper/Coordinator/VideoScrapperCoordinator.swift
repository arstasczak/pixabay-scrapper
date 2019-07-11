//
//  VideoScrapperCoordinator.swift
//  PixabayScrapper
//
//  Created by Arkadiusz Staśczak on 04/05/2019.
//  Copyright © 2019 Arkadiusz Staśczak. All rights reserved.
//

import Foundation
import UIKit

class VideoScrapperCoordinator: SubCoordinator {
    func goToVideoScrapper() {
        let vc = VideoScrapperViewController(dependencies: dependencies)
        navigationController.pushViewController(vc, animated: true)
    }
}
