//
//  ServiceManager.swift
//  TheStories
//
//  Created by Wil Liam on 6/28/19.
//  Copyright © 2019 William. All rights reserved.
//

import Alamofire

typealias OnFailure = (ErrorRespond?) -> Void

class ServiceManager {
    public var baseURL: String {
        return Constant.baseUrl.rawValue
    }

    static var unsplashHTTPHeaders: HTTPHeaders {
        return [
            "Accept": Constant.applicationJson.rawValue,
            "Content-Type": Constant.applicationJson.rawValue,
            "Accept-Version": Constant.apiVersion.rawValue,
            "Authorization": Constant.clientID.rawValue
        ]
    }

    public class var api: ServiceManager {
        if let shared = self.shared {
            return shared
        }

        fatalError("ServiceManager is not initialized")
    }

    static var shared: ServiceManager?
    private var sessionManager: SessionManager
    public var interceptor: ((Int) -> Void)?

    // MARK: - Initializer
    init(sessionManager: SessionManager) {
        self.sessionManager = sessionManager
    }

    public class func startConnection() {
        let httpHeader = unsplashHTTPHeaders
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.httpCookieAcceptPolicy = .never
        sessionConfig.httpCookieStorage = nil
        sessionConfig.urlCache = nil
        sessionConfig.httpAdditionalHeaders = httpHeader

        let sessionManager = SessionManager(configuration: sessionConfig)
        sessionManager.startRequestsImmediately = true

        if shared == nil {
            shared = ServiceManager(sessionManager: sessionManager  )
        }
    }

    // MARK: - Request API
    func request(_ url: URLRequestConvertible,
                 completionHandler: @escaping (HTTPURLResponse?, Any?, Error?) -> Void) -> DataRequest {
        let dataRequest = sessionManager.request(url)
        dataRequest.responseJSON { (dataResponse) in
            completionHandler(dataResponse.response, dataResponse.result.value, dataResponse.error)
        }

        return dataRequest
    }
}
