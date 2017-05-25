//
//  TriviaAPIService.swift
//  TrivialAsia
//
//  Created by Anastasia Stepanova-Kolupakhina on 25.05.17.
//  Copyright © 2017 Anastasia Kolupakhina. All rights reserved.
//

import Foundation
import Alamofire

class TriviaAPIService {
    
    func getToken(completionHandler: @escaping (TriviaCompletion<TriviaTokenResponse>) -> Void) {
        
        let urlRequest = TriviaAPIRouter.getToken
        Alamofire.request(urlRequest)
            .responseTrivia { (response: DataResponse<TriviaTokenResponse>) in
                
                switch response.result {
                case .failure(let error):
                    let triviaError = error as! TriviaError
                    
                    switch triviaError {
                    case .networkTimeout:
                        break
                        //self.completeSubscription(withId: id, completionHandler: completionHandler)
                        
                        
                        
                    default:
                        completionHandler(.failure(triviaError))
                    }
                    
                case .success(let value):
                    completionHandler(.success(value))
                }
        }
        
        
//        let urlRequest = TriviaAPIRouter.getTriviaList(withAmount: amount, andToken: nil)
//        Alamofire.request(urlRequest)
//            .responseTrivia { (response: DataResponse<TriviaListResponse>) in
//                
//                switch response.result {
//                case .failure(let error):
//                    let triviaError = error as! TriviaError
//                    
//                    switch triviaError {
//                    case .networkTimeout:
//                        break
//                        //self.completeSubscription(withId: id, completionHandler: completionHandler)
//                        
//                        
//                        
//                    default:
//                        completionHandler(.failure(triviaError))
//                    }
//                    
//                case .success(let value):
//                    completionHandler(.success(value))
//                }
//        }
    }
    
    func getTriviaList(withAmount amount: Int, andToken token: String, completionHandler: @escaping (TriviaCompletion<TriviaListResponse>) -> Void) {
        
        let urlRequest = TriviaAPIRouter.getTriviaList(withAmount: amount, andToken: token)
        Alamofire.request(urlRequest)
        .responseTrivia { (response: DataResponse<TriviaListResponse>) in
            
            switch response.result {
            case .failure(let error):
                let triviaError = error as! TriviaError
                completionHandler(.failure(triviaError))
                
            case .success(let value):
                completionHandler(.success(value))
            }
        }
    }
    
}

