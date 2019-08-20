//
//  MockSearchViewRouter.swift
//  TheStoriesTests
//
//  Created by William on 02/07/19.
//  Copyright © 2019 William. All rights reserved.
//

import XCTest

@testable import TheStories
class MockSearchViewRouter: SearchViewRouter {
    var invokedControllerGetter = false
    var invokedControllerGetterCount = 0
    var stubbedController: UIViewController!
    override var controller: UIViewController {
        invokedControllerGetter = true
        invokedControllerGetterCount += 1
        return stubbedController
    }
}
