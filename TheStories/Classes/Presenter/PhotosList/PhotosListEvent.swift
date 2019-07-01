//
//  PhotosListEvent.swift
//  TheStories
//
//  Created by Wil Liam on 6/28/19.
//  Copyright © 2019 William. All rights reserved.
//

import Foundation

protocol PhotosListEvent: class {
    func onRequestListPhotos(startPage: Int, perPage: Int)

    func onSearch(keyword: String, startPage: Int, perPage: Int)
}
