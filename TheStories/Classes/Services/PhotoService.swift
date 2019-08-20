//
//  PhotoService.swift
//  TheStories
//
//  Created by Wil Liam on 6/28/19.
//  Copyright © 2019 William. All rights reserved.
//

import Alamofire

typealias OnCompletion = ([[String: Any]]?, ErrorRespond?) -> Void

class PhotosService {
    init() {}

    func listPhotos(pageNum: Int, perPage: Int, orderBy: String, completion: @escaping OnCompletion) {
        let param: [String: Any] = [Constant.page.rawValue: pageNum,
                                    Constant.perPage.rawValue: perPage,
                                    Constant.orderBy.rawValue: orderBy]

        let url = PhotosPath.photos(param: param)
        _ = ServiceManager.api.request(url) { (_, responseObject, error) in
            if let err = error, err._code != NSURLErrorCancelled {
                let err = ErrorRespond(type: .failedConnection)
                completion(nil, err)

                return
            }

            if let response = responseObject as? [[String: Any]] {
                completion(response, nil)
            }
        }
    }
}
