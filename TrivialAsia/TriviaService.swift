//
//  TriviaService.swift
//  TrivialAsia
//
//  Created by Anastasia Stepanova-Kolupakhina on 25.05.17.
//  Copyright © 2017 Anastasia Kolupakhina. All rights reserved.
//

import Foundation

final class TriviaService {
    
    private let triviaRepositoryService = TriviaRepositoryService()
    private let triviaAPIService = TriviaAPIService()
    
    
    private var token: TriviaToken
    
    init() {
        // load token from DB
        token = TriviaToken()
    }
    
    func getToken(completionHandler: @escaping (TriviaToken?) -> Void) {
        guard !token.isValid else {
            completionHandler(token) // local token is still valid
            return
        }
        
        triviaAPIService.getToken { triviaCompletion in
            switch triviaCompletion {
                
            case .success(let value):
                let processedValue = self.processGetTokenSuccessValue(value)
                completionHandler(processedValue)
                
            case .failure:
                completionHandler(nil)
            }
        }
        
    }
    
    func processGetTokenSuccessValue(_ value: TriviaTokenResponse) -> TriviaToken {
        token = value.token
        return token
    }
    
    func getTriviaList(withAmount amount: Int, completionHandler: @escaping (TriviaCompletion<[Trivia]>) -> Void) {
        
        getToken { token in
            guard let token = token else {
                let responseCodeError = TriviaError.responseCode(error: ResponseCode.tokenNotFound)
                completionHandler(.failure(responseCodeError))
                return
            }
            
            self.triviaAPIService.getTriviaList(withAmount: amount, andToken: token.value) { triviaCompletion in
                
                switch triviaCompletion {
                case .success(let value):
                    let processedValue = self.processGetTriviaListSuccessValue(value)
                    completionHandler(.success(processedValue))
                    
                case .failure(let triviaError):
                    completionHandler(.failure(triviaError))
                }
                
            }
        }
    }
    
    func processGetTriviaListSuccessValue(_ value: TriviaListResponse) -> [Trivia] {
        // return uniqe trivia
        
        return []
    }
    
}
