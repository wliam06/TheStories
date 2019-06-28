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
    var invokedBaseURLGetter = false
    var invokedBaseURLGetterCount = 0
    var stubbedBaseURL: String! = ""
    override var baseURL: String {
        invokedBaseURLGetter = true
        invokedBaseURLGetterCount += 1
        return stubbedBaseURL
    }
    var invokedUnsplashHTTPHeadersGetter = false
    var invokedUnsplashHTTPHeadersGetterCount = 0
    var stubbedUnsplashHTTPHeaders: HTTPHeaders!
    override var unsplashHTTPHeaders: HTTPHeaders {
        invokedUnsplashHTTPHeadersGetter = true
        invokedUnsplashHTTPHeadersGetterCount += 1
        return stubbedUnsplashHTTPHeaders
    }
    var invokedStartConnection = false
    var invokedStartConnectionCount = 0
    override func startConnection() {
        invokedStartConnection = true
        invokedStartConnectionCount += 1
    }
}
