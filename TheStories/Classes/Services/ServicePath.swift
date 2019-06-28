//
//  ServicePath.swift
//  TheStories
//
//  Created by Wil Liam on 6/28/19.
//  Copyright © 2019 William. All rights reserved.
//

import Alamofire

private enum Const {
    static var photos = "/photos"
}

enum SearchPath: URLRequestConvertible {
    case photos

    var method: HTTPMethod {
        return .get
    }

    var path: String {
        switch self {
        case .photos:
            return Const.photos
        }
    }

    func asURLRequest() throws -> URLRequest {
        let baseURL = try ServiceManager.shared.baseURL.asURL()

        var urlRequest = URLRequest(url: baseURL.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue

        return urlRequest
    }
}
