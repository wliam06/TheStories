//
//  MockServiceManager.swift
//  TheStoriesTests
//
//  Created by Wil Liam on 6/28/19.
//  Copyright © 2019 William. All rights reserved.
//

import XCTest

@testable import TheStories
class MockServiceManager: ServiceManager {
    var invokedBaseURLGetter = false
    var invokedBaseURLGetterCount = 0
    var stubbedBaseURL: String! = ""
    override var baseURL: String {
        invokedBaseURLGetter = true
        invokedBaseURLGetterCount += 1
        return stubbedBaseURL
    }
    var invokedUnsplashHTTPHeadersSetter = false
    var invokedUnsplashHTTPHeadersSetterCount = 0
    var invokedUnsplashHTTPHeaders: HTTPHeaders?
    var invokedUnsplashHTTPHeadersList = [HTTPHeaders]()
    var invokedUnsplashHTTPHeadersGetter = false
    var invokedUnsplashHTTPHeadersGetterCount = 0
    var stubbedUnsplashHTTPHeaders: HTTPHeaders!
    override var UnsplashHTTPHeaders: HTTPHeaders {
        set {
            invokedUnsplashHTTPHeadersSetter = true
            invokedUnsplashHTTPHeadersSetterCount += 1
            invokedUnsplashHTTPHeaders = newValue
            invokedUnsplashHTTPHeadersList.append(newValue)
        }
        get {
            invokedUnsplashHTTPHeadersGetter = true
            invokedUnsplashHTTPHeadersGetterCount += 1
            return stubbedUnsplashHTTPHeaders
        }
    }
    var invokedStartConnection = false
    var invokedStartConnectionCount = 0
    override func startConnection() {
        invokedStartConnection = true
        invokedStartConnectionCount += 1
    }
}
