//
//  TriviaTokenResponse.swift
//  TrivialAsia
//
//  Created by Anastasia Stepanova-Kolupakhina on 25.05.17.
//  Copyright © 2017 Anastasia Kolupakhina. All rights reserved.
//

import Foundation
import ObjectMapper

class TriviaTokenResponse: Response {
    var responseMessage = ""
    var token: TriviaToken!
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        responseMessage <- map["response_message"]
        
        var tokenValue = ""
        tokenValue <- map["token"]
        let generationDate = Date()
        
        token = TriviaToken()
        token.value = tokenValue
        token.generationDate = generationDate
    }
    
}
