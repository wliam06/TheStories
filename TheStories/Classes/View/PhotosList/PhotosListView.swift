//
//  PhotosListView.swift
//  TheStories
//
//  Created by Wil Liam on 6/28/19.
//  Copyright © 2019 William. All rights reserved.
//

import Foundation

protocol PhotosListView: class {
    func showListPhotos(withPhotos photos: [Photo])
}
