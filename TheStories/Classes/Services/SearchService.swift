//
//  SearchService.swift
//  TheStories
//
//  Created by Wil Liam on 7/2/19.
//  Copyright © 2019 William. All rights reserved.
//

import Alamofire

typealias OnComplete = ([String: Any]?, ErrorRespond?) -> Void

class SearchService {
    init() {}

    func searchByKeyword(withKeyword keyword: String, pageNum: Int, perPage: Int, completion: @escaping OnComplete) {
        let param: [String: Any] = [Constant.query.rawValue: keyword,
                                    Constant.page.rawValue: pageNum,
                                    Constant.perPage.rawValue: perPage]

        let url = SearchPath.searchByKeyword(param: param)
        _ = ServiceManager.api.request(url) { (_, responseObject, error) in
            if let err = error, err._code != NSURLErrorCancelled {
                let err = ErrorRespond(type: .failedConnection)
                completion(nil, err)

                return
            }

            if let response = responseObject as? [String: Any] {
                completion(response, nil)
            }
        }
    }
}
