//
//  PhotosListViewTests.swift
//  TheStoriesTests
//
//  Created by Wil Liam on 6/28/19.
//  Copyright © 2019 William. All rights reserved.
//

import XCTest

@testable import TheStories

class PhotosListViewTests: XCTestCase {
    var mockEvent: MockPhotosListEvent?
    var view: PhotosListViewController?

    override func setUp() {
        mockEvent = MockPhotosListEvent()
        view = PhotosListViewController()

        view?.event = mockEvent
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
