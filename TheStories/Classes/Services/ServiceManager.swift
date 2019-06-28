//
//  ServiceManager.swift
//  TheStories
//
//  Created by Wil Liam on 6/28/19.
//  Copyright © 2019 William. All rights reserved.
//

import Alamofire

class ServiceManager {
    private init() {}

    static let shared = ServiceManager()

    public var baseURL: String {
        return Constant.baseUrl
    }

    var unsplashHTTPHeaders: HTTPHeaders {
        return [
            "Accept": Constant.applicationJson,
            "Content-Type": Constant.applicationJson,
            "Accept-Version": Constant.apiVersion,
            "Authorization": Constant.clientID
        ]
    }

    func startConnection() {
        let httpHeader = unsplashHTTPHeaders

        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.httpCookieAcceptPolicy = .never
        sessionConfig.httpCookieStorage = nil
        sessionConfig.urlCache = nil
        sessionConfig.httpAdditionalHeaders = httpHeader

        let sessionManager = SessionManager(configuration: sessionConfig)
        sessionManager.startRequestsImmediately = true
    }
}
