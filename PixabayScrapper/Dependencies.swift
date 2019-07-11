//
//  Dependencies.swift
//  PixabayScrapper
//
//  Created by Arkadiusz Staśczak on 11/07/2019.
//  Copyright © 2019 Arkadiusz Staśczak. All rights reserved.
//

import UIKit

class Dependencies {
    var coordinator: CoordinatorProtocol!
}

protocol HasDependenciesProtocol {
    var dependencies: Dependencies { get set }
    init(dependencies: Dependencies)
}

class HasDependencies: NSObject, HasDependenciesProtocol {
    var dependencies: Dependencies
    
    required init(dependencies: Dependencies) {
        self.dependencies = dependencies
        super.init()
    }
}
