//
//  NetworkingHelper.swift
//  PixabayScrapper
//
//  Created by Arkadiusz Staśczak on 13/06/2019.
//  Copyright © 2019 Arkadiusz Staśczak. All rights reserved.
//

import Foundation

class NetworkingHelper: NSObject {
    static let shared = NetworkingHelper()
    
    let mainImagesURL = "https://pixabay.com/api/"
    let mainVideosURL = "https://pixabay.com/api/videos/"
    let pixabayKey = "10666729-f5624a75cf88a2df8d1c74f6c"
}
