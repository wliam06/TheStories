//
//  ServiceManager.swift
//  TheStories
//
//  Created by William on 27/06/19.
//  Copyright © 2019 William. All rights reserved.
//

import Alamofire

class ServiceManager {
    static var UnsplashHTTPHeaders: HTTPHeaders {
        var baseUrl = Constant.baseUrl
        return [
            "Accept": Constant.applicationJson,
            "Content-Type": Constant.applicationJson,
            "Authorization": Constant.clientID
        ]
    }
}
