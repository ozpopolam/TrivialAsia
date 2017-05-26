//
//  TriviaAdapted.swift
//  TrivialAsia
//
//  Created by Anastasia Stepanova-Kolupakhina on 25.05.17.
//  Copyright © 2017 Anastasia Kolupakhina. All rights reserved.
//

import Foundation
import UIKit

class TriviaViewAdapted {
    var id = 0
    var difficulty = ""
    var question = ""
    var correctAnswer = ""
    var incorrectAnswers = [String]()
    
    init(fromTrivia trivia: Trivia) {
        id = trivia.id
        difficulty = trivia.difficulty
        question = String(fromHtmlEncoded: trivia.question)
        correctAnswer = String(fromHtmlEncoded: trivia.correctAnswer)
        incorrectAnswers = trivia.incorrectAnswers.map { String(fromHtmlEncoded: $0) }
    }
}

extension String {
    init(fromHtmlEncoded htmlEncodedString: String) {
        self.init()
        guard let encodedData = htmlEncodedString.data(using: .utf8) else {
            self = htmlEncodedString
            return
        }
        
        let attributedOptions: [String : Any] = [
            NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
            NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue
        ]
        
        do {
            let attributedString = try NSAttributedString(data: encodedData, options: attributedOptions, documentAttributes: nil)
            self = attributedString.string
        } catch {
            print("Error: \(error)")
            self = htmlEncodedString
        }
    }
}
