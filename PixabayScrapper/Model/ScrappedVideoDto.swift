//
//  ScrappedVideoDto.swift
//  PixabayScrapper
//
//  Created by Arkadiusz Staśczak on 15/06/2019.
//  Copyright © 2019 Arkadiusz Staśczak. All rights reserved.
//

import UIKit
import SwiftyJSON

enum VideoType: String, CaseIterable {
    case large
    case medium
    case small
    case tiny
}

struct Video {
    let videoURL: String
    let width: Int
    let height: Int
    
    
    init(url: String, width: Int, height: Int) {
        self.videoURL = url
        self.width = width
        self.height = height
    }
}

class ScrappedVideoDto: NSObject {
    let imageURL: String
    let videos: [Video]
    let views: Int
    let downloads: Int
    let likes: Int
    let user: String
    
    init(with json: JSON) {
        self.imageURL = json["userImageURL"].stringValue
        self.views = json["views"].intValue
        self.downloads = json["downloads"].intValue
        self.likes = json["likes"].intValue
        self.user = json["user"].stringValue
        
        var videosArray: [Video] = []
        let videosJson = json["videos"].dictionaryValue
        for type in VideoType.allCases {
            if let videoJson = videosJson[type.rawValue] {
                let video = Video(url: videoJson["url"].stringValue, width: videoJson["width"].intValue, height: videoJson["height"].intValue)
                videosArray.append(video)
            }
        }
        self.videos = videosArray
    }
}
