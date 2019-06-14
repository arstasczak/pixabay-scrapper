//
//  ImageScrapperViewModel.swift
//  PixabayScrapper
//
//  Created by Arkadiusz Staśczak on 09/06/2019.
//  Copyright © 2019 Arkadiusz Staśczak. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ImageScrapperViewModel: NSObject {
    private var disposeBag = DisposeBag()
    let view: ImageScrapperView
    
    init(imageScrapperView: ImageScrapperView) {
        imageScrapperView.setup()
        self.view = imageScrapperView
    }
}
