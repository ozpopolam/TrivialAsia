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
    @objc dynamic var id = 0
    @objc dynamic var generationDate = Date()
    @objc dynamic var value = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    var isValid: Bool {
        guard let deadlineTokenDate = Calendar.current.date(byAdding: .hour, value: 6, to: generationDate) else { // lifespan of session token
            return false
        }

        return deadlineTokenDate > Date()
    }
}
