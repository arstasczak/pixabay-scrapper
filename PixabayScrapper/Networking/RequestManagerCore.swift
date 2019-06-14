//
//  RequestManagerCore.swift
//  PixabayScrapper
//
//  Created by Arkadiusz Staśczak on 09/06/2019.
//  Copyright © 2019 Arkadiusz Staśczak. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

enum APIMethod: String {
    case post
    case get
}

class RequestManagerCore: NSObject {
    lazy var apiManager: Alamofire.SessionManager = {
       let sessionManagerConfiguration = URLSessionConfiguration.init()
        sessionManagerConfiguration.timeoutIntervalForRequest = 60
        sessionManagerConfiguration.timeoutIntervalForResource = 60
        return Alamofire.SessionManager(configuration: sessionManagerConfiguration)
    }()
    
    func apiRequest(url: String, method: HTTPMethod, params: [String:AnyObject]?, encoding: ParameterEncoding, closure: @escaping (_ data: JSON?, _ success: Bool) -> Void) {
        
        Alamofire.request(url, method: method, parameters: params, encoding: encoding, headers: [:]).responseJSON { (response) in
//            guard let `self` = self else {return}
//            let statusCode = response.response?.statusCode
//
            print(response)
            switch response.result {
            case .success(_):
                if let responseData = response.data {
                    let parsedJSON = try? JSON.init(data: responseData)

                    closure(parsedJSON, true)
                    return
                }
                closure(nil, false)
            case let .failure(error):
                print(error.localizedDescription)
                closure(nil, false)
            }
            
        }
        
    }
}
