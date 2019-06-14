//
//  ScrappedImageDto.swift
//  PixabayScrapper
//
//  Created by Arkadiusz Staśczak on 09/06/2019.
//  Copyright © 2019 Arkadiusz Staśczak. All rights reserved.
//

import UIKit
import SwiftyJSON

class ScrappedImageDto: NSObject {
    var imageURL: String = ""
    var thumbnailURL: String = ""
    var downloads: Int = 0
    var numberOfViews: Int = 0
    var numberOfLikes: Int = 0
    
    init(with json: JSON) {
        self.imageURL = json["previewURL"].stringValue
        self.thumbnailURL = json["imageURL"].stringValue
        self.downloads = json[""].intValue
        self.numberOfViews = json[""].intValue
        self.numberOfLikes = json[""].intValue
    }
}
