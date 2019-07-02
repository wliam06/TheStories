//
//  MockPhotosListEvent.swift
//  TheStoriesTests
//
//  Created by Wil Liam on 6/28/19.
//  Copyright © 2019 William. All rights reserved.
//

import XCTest

@testable import TheStories
class MockPhotosListEvent: PhotosListEvent {
    var invokedOnRequestListPhotos = false
    var invokedOnRequestListPhotosCount = 0
    var invokedOnRequestListPhotosParameters: (startPage: Int, perPage: Int, selectedType: String)?
    var invokedOnRequestListPhotosParametersList = [(startPage: Int, perPage: Int, selectedType: String)]()
    func onRequestListPhotos(startPage: Int, perPage: Int, selectedType: String) {
        invokedOnRequestListPhotos = true
        invokedOnRequestListPhotosCount += 1
        invokedOnRequestListPhotosParameters = (startPage, perPage, selectedType)
        invokedOnRequestListPhotosParametersList.append((startPage, perPage, selectedType))
    }
}
