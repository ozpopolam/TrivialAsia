//
//  TriviaAdapted.swift
//  TrivialAsia
//
//  Created by Anastasia Stepanova-Kolupakhina on 25.05.17.
//  Copyright © 2017 Anastasia Kolupakhina. All rights reserved.
//

import Foundation

class TriviaViewAdapted {
    var id = 0
    var difficulty = ""
    var question = ""
    var answers = [String]()
    
    init(fromTrivia trivia: Trivia) {
        id = trivia.id
        difficulty = trivia.difficulty
        question = trivia.question

        answers.append(trivia.correctAnswer)
        answers.append(contentsOf: trivia.incorrectAnswers)

        answers.shuffle(withStubbornnessLevel: 3)
    }
}
