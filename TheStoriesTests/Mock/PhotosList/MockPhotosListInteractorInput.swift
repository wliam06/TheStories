//
//  MockPhotosListInteractorInput.swift
//  TheStoriesTests
//
//  Created by Wil Liam on 6/28/19.
//  Copyright © 2019 William. All rights reserved.
//

import XCTest

@testable import TheStories
class MockPhotosListInteractorInput: PhotosListInteractorInput {
    var invokedRequestListPhotos = false
    var invokedRequestListPhotosCount = 0
    var invokedRequestListPhotosParameters: (startPage: Int, perPage: Int, selectedBy: String)?
    var invokedRequestListPhotosParametersList = [(startPage: Int, perPage: Int, selectedBy: String)]()
    func requestListPhotos(startPage: Int, perPage: Int, selectedBy: String) {
        invokedRequestListPhotos = true
        invokedRequestListPhotosCount += 1
        invokedRequestListPhotosParameters = (startPage, perPage, selectedBy)
        invokedRequestListPhotosParametersList.append((startPage, perPage, selectedBy))
    }
}
