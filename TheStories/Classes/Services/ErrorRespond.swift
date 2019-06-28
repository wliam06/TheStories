//
//  ErrorRespond.swift
//  TheStories
//
//  Created by Wil Liam on 6/28/19.
//  Copyright © 2019 William. All rights reserved.
//

import Foundation

enum ErrorType: Equatable {
    case errorResponse(errorMessage: String)
    case failedConnection
    case errorMessage
}

struct ErrorRespond: Error, Equatable {
    let type: ErrorType

    var message: String {
        switch type {
        case .errorResponse(let errorMessage):
            return errorMessage
        case .failedConnection:
            return "An error occurred during connection. Please try again."
        case .errorMessage:
            return "An unexpected error occured. Please try again."
        }
    }

    init(type: ErrorType) {
        self.type = type
    }

    static func == (lhs: ErrorRespond, rhs: ErrorRespond) -> Bool {
        return lhs.type == rhs.type
    }
}
