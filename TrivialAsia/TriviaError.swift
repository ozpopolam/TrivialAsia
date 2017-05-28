//
//  TriviaError.swift
//  TrivialAsia
//
//  Created by Anastasia Stepanova-Kolupakhina on 25.05.17.
//  Copyright © 2017 Anastasia Kolupakhina. All rights reserved.
//

import Foundation

enum TriviaError: Error {
    case networkTimeout
    case noInternetConnection
    case network(error: Error)
    case responseCode(error: ResponseCode)
    case other(reason: String)
}

extension TriviaError: CustomStringConvertible {
    var description: String {
        switch self {
        case .networkTimeout:
            return "network timeout"
        case .noInternetConnection:
            return "no Internet connection"
        case .network(let error):
            return error.localizedDescription
        case .responseCode:
            return "wrong response code"
        case .other(let reason):
            return reason
        }
    }
}
