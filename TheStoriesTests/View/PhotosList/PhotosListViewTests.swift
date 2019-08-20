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
    }

    func testDidRequestPhotosList() {
        view?.viewDidLoad()

//        mockEvent?.onRequestListPhotos(startPage: 1, perPage: 10, selectedType: "Latest")

        XCTAssert(mockEvent?.invokedOnRequestListPhotos == true, "Expect onRequestListPhotos is called once")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
