//
//  MockServiceManager.swift
//  TheStoriesTests
//
//  Created by Wil Liam on 6/28/19.
//  Copyright © 2019 William. All rights reserved.
//

import XCTest
import Alamofire

@testable import TheStories
class MockServiceManager: ServiceManager {
    convenience init() {
        self.init(sessionManager: SessionManager())
    }
    var invokedBaseURLGetter = false
    var invokedBaseURLGetterCount = 0
    var stubbedBaseURL: String! = ""
    override var baseURL: String {
        invokedBaseURLGetter = true
        invokedBaseURLGetterCount += 1
        return stubbedBaseURL
    }
    var invokedInterceptorSetter = false
    var invokedInterceptorSetterCount = 0
    var invokedInterceptor: ((Int) -> Void)?
    var invokedInterceptorList = [((Int) -> Void)?]()
    var invokedInterceptorGetter = false
    var invokedInterceptorGetterCount = 0
    var stubbedInterceptor: ((Int) -> Void)!
    override var interceptor: ((Int) -> Void)? {
        set {
            invokedInterceptorSetter = true
            invokedInterceptorSetterCount += 1
            invokedInterceptor = newValue
            invokedInterceptorList.append(newValue)
        }
        get {
            invokedInterceptorGetter = true
            invokedInterceptorGetterCount += 1
            return stubbedInterceptor
        }
    }
    var invokedRequest = false
    var invokedRequestCount = 0
    var invokedRequestParameters: (url: URLRequestConvertible, Void)?
    var invokedRequestParametersList = [(url: URLRequestConvertible, Void)]()
    var stubbedRequestCompletionHandlerResult: (HTTPURLResponse?, Any?, Error?)?
    var stubbedRequestResult: DataRequest!
    override func request(_ url: URLRequestConvertible,
    completionHandler: @escaping (HTTPURLResponse?, Any?, Error?) -> Void) -> DataRequest {
        invokedRequest = true
        invokedRequestCount += 1
        invokedRequestParameters = (url, ())
        invokedRequestParametersList.append((url, ()))
        if let result = stubbedRequestCompletionHandlerResult {
            completionHandler(result.0, result.1, result.2)
        }
        return stubbedRequestResult
    }
}
