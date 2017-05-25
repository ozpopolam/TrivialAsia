//
//  TriviaCompletion.swift
//  TrivialAsia
//
//  Created by Anastasia Stepanova-Kolupakhina on 25.05.17.
//  Copyright © 2017 Anastasia Kolupakhina. All rights reserved.
//

import Foundation

enum TriviaCompletion<T> {
    case success(T)
    case failure(TriviaError)
    
    var value: T? {
        switch self {
        case .success(let value):
            return value
        case .failure:
            return nil
        }
    }
    
    var error: TriviaError? {
        switch self {
        case .success:
            return nil
        case .failure(let error):
            return error
        }
    }
}
