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
    
    dynamic var id = 0
    dynamic var category = ""
    dynamic var type = ""
    dynamic var difficulty = ""
    dynamic var question = ""
    dynamic var correctAnswer = ""
    dynamic var incorrectAnswersJoined = ""
    
    var incorrectAnswers: [String] {
        return incorrectAnswersJoined.components(separatedBy: answersSeparator)
    }
    
    dynamic var uploadDate = Date()
    dynamic var isAnswered = false
    
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
        uploadDate = Date()
    }
}
