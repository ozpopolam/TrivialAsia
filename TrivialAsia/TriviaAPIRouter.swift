//
//  TriviaAPIRouter.swift
//  TrivialAsia
//
//  Created by Anastasia Stepanova-Kolupakhina on 25.05.17.
//  Copyright © 2017 Anastasia Kolupakhina. All rights reserved.
//

import Alamofire

enum TriviaAPIRouter: Routing {
    static let httpsServerURL = URL(string: "https://opentdb.com/")!
    
    case getToken
    case getTriviaList(withAmount: Int, andToken: String?)
    
    var path: String {
        switch self {
        case .getToken:
            return "api_token.php"
        case .getTriviaList:
            return "api.php"
        }
    }
    
    var url: URL {
        return TriviaAPIRouter.httpsServerURL.appendingPathComponent(path)
    }
    
    var method: HTTPMethod {
        switch self {
        case .getToken,
             .getTriviaList:
            return .get
        }
    }
    
    var parameters: Parameters {
        switch self {
            
        case .getToken:
            return [
                "command": "request"
            ]
            
        case .getTriviaList(let amount, let token):
            return [
                "amount": amount
            ]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        var urlRequest = try URLRequest(url: url, method: method)
        urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        return urlRequest
    }
}
