//
//  PhotosListInteractor.swift
//  TheStories
//
//  Created by Wil Liam on 6/28/19.
//  Copyright © 2019 William. All rights reserved.
//

import Foundation

class PhotosListInteractor: PhotosListInteractorInput {
    weak var output: PhotosListInteractorOutput?

    func requestListPhotos(withPhotos photos: [Photo], pageNum: Int) {
        PhotosService().listPhotos(pageNum: pageNum) { [weak self] (response, error) in
            if let error = error {
                self?.output?.foundErrorRequest(error: error)
                return
            }

            var photos = photos

            guard let result = response else {
                self?.output?.foundListPhotos(withPhotos: photos, page: pageNum)

                return
            }

            // Added new item
            for data in result {
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
                    let photo = try JSONDecoder().decode(Photo.self, from: jsonData)

                    photos.append(photo)
                } catch {
                    debugPrint("Data cannot be converted")
                }
            }

            self?.output?.foundListPhotos(withPhotos: photos, page: pageNum)
        }
    }
}
