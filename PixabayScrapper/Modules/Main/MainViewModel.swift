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
    var tileSelected: ((MainButtonItem) -> Void)?
    let view: MainView
    
    init(mainView: MainView) {
        mainView.setup()
        self.view = mainView
    }
    
    func setupView() {
        view.imageButton.addTarget(self, action: #selector(tileClicked(_:)), for: .touchUpInside)
        view.videoButton.addTarget(self, action: #selector(tileClicked(_:)), for: .touchUpInside)
    }
    
    @objc func tileClicked(_ sender: UIControl) {
        guard let tile = MainButtonItem(rawValue: sender.tag) else { return }
        tileSelected?(tile)
    }
}
