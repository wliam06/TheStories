//
//  SearchPath.swift
//  TheStories
//
//  Created by Wil Liam on 7/2/19.
//  Copyright © 2019 William. All rights reserved.
//

import Alamofire

private enum Const {
    static var searchKeyword = "/search/photos"
}

public enum SearchPath: URLRequestConvertible {
    case searchByKeyword(param: Parameters)

    var method: HTTPMethod {
        return .get
    }

    var path: String {
        switch self {
        case .searchByKeyword:
            return Const.searchKeyword
        }
    }

    public func asURLRequest() throws -> URLRequest {
        let baseURL = try ServiceManager.api.baseURL.asURL()

        var urlRequest = URLRequest(url: baseURL.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue

        switch self {
        case .searchByKeyword(let param):
            urlRequest = try URLEncoding.default.encode(urlRequest, with: param)
        }

        debugPrint("Requesting: \(urlRequest)")
        return urlRequest
    }
}
