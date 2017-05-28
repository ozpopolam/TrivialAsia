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
        
        let routingRequest = TriviaAPIRouter.getToken
        AlamofireHelper.printOutcomingUrlRequest(routingRequest.urlRequest)

        Alamofire.request(routingRequest)
            .responseTrivia { (response: DataResponse<TriviaTokenResponse>) in
                response.processResponseTrivia(withBlock: {
                    self.getToken(completionHandler: completionHandler)
                }, andCompletionHandler: completionHandler)
        }
    }

    func getTriviaList(withAmount amount: Int,
                       andToken token: String,
                       completionHandler: @escaping (TriviaCompletion<TriviaListResponse>) -> Void) {

        let routingRequest = TriviaAPIRouter.getTriviaList(withAmount: amount, andToken: token)
        AlamofireHelper.printOutcomingUrlRequest(routingRequest.urlRequest)

        Alamofire.request(routingRequest)
            .responseTrivia { (response: DataResponse<TriviaListResponse>) in
                response.processResponseTrivia(withBlock: {
                    self.getTriviaList(withAmount: amount, andToken: token, completionHandler: completionHandler)
                }, andCompletionHandler: completionHandler)
        }
    }
    
}
