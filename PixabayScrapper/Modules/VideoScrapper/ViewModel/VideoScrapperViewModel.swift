//
//  VideoScrapperViewModel.swift
//  PixabayScrapper
//
//  Created by Arkadiusz Staśczak on 16/06/2019.
//  Copyright © 2019 Arkadiusz Staśczak. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class VideoScrapperViewModel: NSObject {
    private var disposeBag = DisposeBag()
    let view: VideoScrapperView
    
    init(videoScrapperView: VideoScrapperView) {
        videoScrapperView.setup()
        self.view = videoScrapperView
    }
}
