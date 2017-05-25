//
//  Trivia.swift
//  TrivialAsia
//
//  Created by Anastasia Stepanova-Kolupakhina on 25.05.17.
//  Copyright © 2017 Anastasia Kolupakhina. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class Trivia: Object, Mappable {
    var id = 0
    var category = ""
    var type = ""
    var difficulty = ""
    var question = ""
    var correctAnswer = ""
    //var incorrectAnswers = [String]()
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func mapping(map: Map) {
        category <- map["category"]
        type <- map["type"]
        difficulty <- map["difficulty"]
        question <- map["question"]
        correctAnswer <- map["correct_answer"]
        //incorrectAnswers <- map["incorrect_answers"]
        
        id = (category + question + correctAnswer).hashValue
    }
}
