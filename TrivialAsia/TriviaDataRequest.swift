//
//  TriviaDataRequest.swift
//  TrivialAsia
//
//  Created by Anastasia Stepanova-Kolupakhina on 25.05.17.
//  Copyright © 2017 Anastasia Kolupakhina. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

extension DataRequest {
    static func responseTriviaSerializer<T: TriviaMappable>() -> DataResponseSerializer<T> {
        return DataResponseSerializer { request, response, data, error in
            
            guard error == nil else { // network errors
                if let error = error as NSError?, error.code == NSURLErrorTimedOut {
                    let networkTimeoutError = TriviaError.networkTimeout
                    return .failure(networkTimeoutError)
                    
                } else if let error = error as NSError?, error.code == NSURLErrorNotConnectedToInternet {
                    let noInternetConnectionError = TriviaError.noInternetConnection
                    return .failure(noInternetConnectionError)
                    
                } else {
                    let networkError = TriviaError.network(error: error!)
                    return .failure(networkError)
                }
            }
            
            // serialize JSON to Jelly-object
            let result = Request.serializeResponseJSON(options: .allowFragments, response: response, data: data, error: nil)
            
            guard case let .success(jsonData) = result else {
                let otherError = TriviaError.other(reason: "Serialization error")
                return .failure(otherError)
            }
            
            guard let jsonDictionary = jsonData as? [String: AnyObject] else {
                let otherError = TriviaError.other(reason: "Downcasting error")
                return .failure(otherError)
            }
            
            guard let object = Mapper<T>().map(JSON: jsonDictionary) else {
                let otherError = TriviaError.other(reason: "Mapping error")
                return .failure(otherError)
            }
            
            guard let responseCode = ResponseCode(rawValue: object.responseCode) else {
                let otherError = TriviaError.other(reason: "Unknown error from response code")
                return .failure(otherError)
            }
            
            if responseCode == .success {
                return .success(object)
                
            } else {
                let responseCodeError = TriviaError.responseCode(error: responseCode)
                return .failure(responseCodeError)
            }
            
        }
    }
    
    @discardableResult
    func responseTrivia<T: TriviaMappable>(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self
    {
        return response(queue: queue, responseSerializer: DataRequest.responseTriviaSerializer(), completionHandler: completionHandler)
    }
}

//extension DataResponse where Value: TriviaMappable {
//    
//    func processResponseJelly(withBlock block: @escaping () -> Void, andCompletionHandler completionHandler: @escaping (TriviaCompletion<Value>) -> Void) {
//        switch self.result {
//            
//        case .failure(let error):
//            let triviaError = error as! TriviaError
//            
//            switch triviaError {
//            case .networkTimeout:
//                block()
//                
//            case .unauthorized:
//                LoginHelper.getInstance()?.reSignIn {
//                    block()
//                }
//                
//            default:
//                completionHandler(.failure(jellyError))
//            }
//            
//            
//        case .success(let value):
//            completionHandler(.success(value))
//        }
//    }
//}
