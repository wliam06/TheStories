//
//  MockPhotosListRouter.swift
//  TheStoriesTests
//
//  Created by Wil Liam on 6/28/19.
//  Copyright © 2019 William. All rights reserved.
//

import XCTest

@testable import TheStories
class MockPhotosListRouter: PhotosListRouter {
    var invokedControllerGetter = false
    var invokedControllerGetterCount = 0
    var stubbedController: UIViewController!
    override var controller: UIViewController {
        invokedControllerGetter = true
        invokedControllerGetterCount += 1
        return stubbedController
    }
}
