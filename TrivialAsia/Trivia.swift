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
    private let answersSeparator = "~"
    
    var id = 0
    var category = ""
    var type = ""
    var difficulty = ""
    var question = ""
    var correctAnswer = ""
    var incorrectAnswersJoined = ""
    
    var incorrectAnswers: [String] {
        return incorrectAnswersJoined.components(separatedBy: answersSeparator)
    }
    
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
        
        var incorrectAnswersMapped = [String]()
        incorrectAnswersMapped <- map["incorrect_answers"]
        incorrectAnswersJoined = incorrectAnswersMapped.map({$0}).joined(separator: answersSeparator)
        
        id = (category + question + correctAnswer).hashValue
    }
}
