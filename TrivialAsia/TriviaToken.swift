//
//  TriviaToken.swift
//  TrivialAsia
//
//  Created by Anastasia Stepanova-Kolupakhina on 25.05.17.
//  Copyright © 2017 Anastasia Kolupakhina. All rights reserved.
//

import Foundation
import RealmSwift

class TriviaToken: Object {
    dynamic var id = 0
    dynamic var generationDate = Date()
    dynamic var value = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    var isValid: Bool {
        return !value.isEmpty
    }
}
