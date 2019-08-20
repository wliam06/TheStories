//
//  MockPhotosListView.swift
//  TheStoriesTests
//
//  Created by Wil Liam on 6/28/19.
//  Copyright © 2019 William. All rights reserved.
//

import XCTest

@testable import TheStories
class MockPhotosListView: PhotosListView {
    var invokedShowListPhotos = false
    var invokedShowListPhotosCount = 0
    var invokedShowListPhotosParameters: (photos: [Photo], page: Int, imageViewModel: [ImageViewModel])?
    var invokedShowListPhotosParametersList = [(photos: [Photo], page: Int, imageViewModel: [ImageViewModel])]()
    func showListPhotos(withPhotos photos: [Photo], page: Int, imageViewModel: [ImageViewModel]) {
        invokedShowListPhotos = true
        invokedShowListPhotosCount += 1
        invokedShowListPhotosParameters = (photos, page, imageViewModel)
        invokedShowListPhotosParametersList.append((photos, page, imageViewModel))
    }
}
