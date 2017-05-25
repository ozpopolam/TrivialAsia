//
//  TriviaToken.swift
//  TrivialAsia
//
//  Created by Anastasia Stepanova-Kolupakhina on 25.05.17.
//  Copyright © 2017 Anastasia Kolupakhina. All rights reserved.
//

import Foundation

class TriviaToken {
    var generationDate = Date()
    var value = ""
    
    var isValid: Bool {
        return !value.isEmpty
    }
}
