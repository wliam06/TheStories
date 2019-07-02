//
//  SearchView.swift
//  TheStories
//
//  Created by Wil Liam on 7/1/19.
//  Copyright © 2019 William. All rights reserved.
//

import Foundation

protocol SearchView: class {
    func showListPhotos(withPhotos photos: [Photo], page: Int, imageViewModel: [ImageViewModel])
}
