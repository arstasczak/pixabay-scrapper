//
//  MainViewModel.swift
//  PixabayScrapper
//
//  Created by Arkadiusz Staśczak on 04/05/2019.
//  Copyright © 2019 Arkadiusz Staśczak. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

final class MainViewModel: NSObject {
    let disposeBag = DisposeBag()
    
    init(mainView: MainView) {
        mainView.setup()
    }
}
