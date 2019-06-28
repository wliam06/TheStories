//
//  ServiceManager.swift
//  TheStories
//
//  Created by William on 27/06/19.
//  Copyright © 2019 William. All rights reserved.
//

import Alamofire

class ServiceManager {
    private init() {}

    static let shared = ServiceManager()

    public var baseURL: String {
        return Constant.baseUrl
    }

    public var unsplashHTTPHeaders: HTTPHeaders {
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
