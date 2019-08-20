//
//  MockSearcViewEvent.swift
//  TheStoriesTests
//
//  Created by William on 02/07/19.
//  Copyright © 2019 William. All rights reserved.
//

import XCTest

@testable import TheStories
class MockSearcViewEvent: SearchViewEvent {
    var invokedOnSearch = false
    var invokedOnSearchCount = 0
    var invokedOnSearchParameters: (keyword: String, startPage: Int, perPage: Int)?
    var invokedOnSearchParametersList = [(keyword: String, startPage: Int, perPage: Int)]()
    func onSearch(keyword: String, startPage: Int, perPage: Int) {
        invokedOnSearch = true
        invokedOnSearchCount += 1
        invokedOnSearchParameters = (keyword, startPage, perPage)
        invokedOnSearchParametersList.append((keyword, startPage, perPage))
    }
}
