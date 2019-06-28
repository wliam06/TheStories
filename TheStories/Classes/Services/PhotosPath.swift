//
//  PhotosPath.swift
//  TheStories
//
//  Created by Wil Liam on 6/28/19.
//  Copyright © 2019 William. All rights reserved.
//

import Alamofire

private enum Const {
    static var photos = "/photos"
}

public enum PhotosPath: URLRequestConvertible {
    case photos(param: Parameters)

    var method: HTTPMethod {
        return .get
    }

    var path: String {
        switch self {
        case .photos:
            return Const.photos
        }
    }

    public func asURLRequest() throws -> URLRequest {
        let baseURL = try ServiceManager.api.baseURL.asURL()

        var urlRequest = URLRequest(url: baseURL.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue

        switch self {
        case .photos(let param):
            urlRequest = try URLEncoding.default.encode(urlRequest, with: param)
        }

        debugPrint("Requesting: \(urlRequest)")
        return urlRequest
    }
}
