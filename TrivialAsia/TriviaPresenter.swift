//
//  TriviaPresenter.swift
//  TrivialAsia
//
//  Created by Anastasia Stepanova-Kolupakhina on 25.05.17.
//  Copyright © 2017 Anastasia Kolupakhina. All rights reserved.
//

import Foundation

class TriviaPresenter {
    weak private var view: TriviaView?
    
    private let triviaRepositoryService = TriviaRepositoryService()
    private let triviaAPIService = TriviaAPIService()
    
    private let amountOfTriviaToUpload = 10
    private var triviaIsBeingLoded = false
    private var token: TriviaToken?
    private var triviaList = [Trivia]()
    
    init() {
        token = triviaRepositoryService.getTriviaToken()
    }
    
    func attachView(view: TriviaView) {
        self.view = view
    }
    
    func detachView() {
        self.view = nil
    }
    
    func getTriviaList() {
        guard !triviaIsBeingLoded else { return }
        triviaIsBeingLoded = true
        
        view?.showNotification(TriviaViewNotification.isBeingLoaded)
        
        getTriviaList(withAmount: amountOfTriviaToUpload) { triviaCompletion in
            self.triviaIsBeingLoded = false

            switch triviaCompletion {
            case .failure(let triviaError):
                
                switch triviaError {
                case .networkTimeout, .noInternetConnection, .network:
                    self.view?.showNotification(TriviaViewNotification.checkInternetConnection)
                    
                case .responseCode:
                    self.view?.showNotification(TriviaViewNotification.sorryNoTrivia)
                    
                default:
                    break
                }
                
            case .success(let triviaList):
                let triviaAdaptedList = triviaList.map { TriviaViewAdapted(fromTrivia: $0) }
                self.view?.addTriviaAdaptedList(triviaAdaptedList)
            }
        }
    }
    
    private func getToken(completionHandler: @escaping (TriviaToken?) -> Void) {
        if let token = token, token.isValid {
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
    
    private func processGetTokenSuccessValue(_ value: TriviaTokenResponse) -> TriviaToken {
        token = value.token
        triviaRepositoryService.setTriviaToken(value.token)
        return value.token
    }
    
    private func getTriviaList(withAmount amount: Int, completionHandler: @escaping (TriviaCompletion<[Trivia]>) -> Void) {
        
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
                    if case .responseCode(let error) = triviaError, error == .tokenNotFound {
                        self.token = nil
                        self.getTriviaList(withAmount: amount, completionHandler: completionHandler)

                    } else {
                        completionHandler(.failure(triviaError))
                    }

                }
                
            }
        }
    }
    
    private func processGetTriviaListSuccessValue(_ value: TriviaListResponse) -> [Trivia] {
        
        let answeredTrivia = triviaRepositoryService.getAnsweredTrivia()
        guard !(answeredTrivia.isEmpty && triviaList.isEmpty) else { return [] }

        var newTrivia = [Trivia]()
        for trivia in value.list {
            if !triviaList.contains(where: { $0 == trivia }) && // new trivia shouldn't be in already exesting list
                !answeredTrivia.contains(where: { $0 == trivia }) { // and in answered ones
                newTrivia.append(trivia)
            }
        }
        
        guard newTrivia.count > 0 else { return [] }
        
        triviaList.append(contentsOf: newTrivia)
        return newTrivia
    }
    
}
