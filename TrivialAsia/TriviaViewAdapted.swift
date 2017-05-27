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

    var correctAnswerId = -1
    var answers = [String]()
    
    init(fromTrivia trivia: Trivia) {
        id = trivia.id
        difficulty = trivia.difficulty
        question = String(fromHtmlEncoded: trivia.question)

        answers.append(String(fromHtmlEncoded: trivia.correctAnswer))
        let incorrectAnswers = trivia.incorrectAnswers.map { String(fromHtmlEncoded: $0) }
        answers.append(contentsOf: incorrectAnswers)
    }

    func isAnswerCorrect(_ answer: String) -> Bool {
        return answer == answers[correctAnswerId]
    }
}
