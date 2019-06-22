//
//  RequestManager.swift
//  PixabayScrapper
//
//  Created by Arkadiusz Staśczak on 09/06/2019.
//  Copyright © 2019 Arkadiusz Staśczak. All rights reserved.
//

import UIKit
import Alamofire

class RequestManager: RequestManagerCore {
    static let shared = RequestManager()
    
    func getPhotos(query: String, page: Int, closure: @escaping (_ scrappedImages: [ScrappedImageDto]) -> Void) {
        var params: [String:AnyObject] = [:]
        params["key"] = NetworkingHelper.shared.pixabayKey as AnyObject
        params["q"] = query as AnyObject
        params["page"] = page as AnyObject
        
        let url = NetworkingHelper.shared.mainImagesURL
        
        apiRequest(url: url, method: .get, params: params, encoding: URLEncoding.default) { (responseJSON, success)  in
            var scrappedImages: [ScrappedImageDto] = []
            if let responseJSON = responseJSON {
                for item in responseJSON["hits"].arrayValue {
                    scrappedImages.append(ScrappedImageDto(with: item))
                }
            }
            closure(scrappedImages)
        }
    }
    
    func getVideos(query: String, page: Int, closure: @escaping (_ scrappedVideos: [ScrappedVideoDto]) -> Void) {
        var params: [String:AnyObject] = [:]
        params["key"] = NetworkingHelper.shared.pixabayKey as AnyObject
        params["q"] = query as AnyObject
        params["page"] = page as AnyObject
        
        let url = NetworkingHelper.shared.mainVideosURL
        
        apiRequest(url: url, method: .get, params: params, encoding: URLEncoding.default) { (responseJSON, success) in
            var scrappedVideos: [ScrappedVideoDto] = []
            if let responseJSON = responseJSON {
                for item in responseJSON["hits"].arrayValue {
                    scrappedVideos.append(ScrappedVideoDto(with: item))
                }
            }
            closure(scrappedVideos)
        }
    }
}
