//
//  FullImageViewCoordinator.swift
//  PixabayScrapper
//
//  Created by Arkadiusz Staśczak on 11/07/2019.
//  Copyright © 2019 Arkadiusz Staśczak. All rights reserved.
//

import UIKit

class FullImageViewCoordinator: SubCoordinator {
    func fullImage(imageUrl: String) {
        let vc = ImageFullViewController(imageUrl: imageUrl)
        navigationController.pushViewController(vc, animated: true)
    }
}
