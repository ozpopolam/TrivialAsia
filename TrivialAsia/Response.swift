//
//  Response.swift
//  TrivialAsia
//
//  Created by Anastasia Stepanova-Kolupakhina on 25.05.17.
//  Copyright © 2017 Anastasia Kolupakhina. All rights reserved.
//

import Foundation
import ObjectMapper

class Response: TriviaMappable {
    var responseCode = -1
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        responseCode <- map["response_code"]
    }
}
