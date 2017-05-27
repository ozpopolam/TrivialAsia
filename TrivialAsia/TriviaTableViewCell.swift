//
//  TriviaTableViewCell.swift
//  TrivialAsia
//
//  Created by Anastasia Stepanova-Kolupakhina on 27.05.17.
//  Copyright © 2017 Anastasia Kolupakhina. All rights reserved.
//

import UIKit
enum TriviaColor {
    static let pink = UIColor(red: 255.0 / 255.0, green:  45.0 / 255.0, blue: 85.0 / 255.0, alpha: 1.0)

    static let tealBlue = UIColor(red: 90.0 / 255.0, green:  200.0 / 255.0, blue: 250.0 / 255.0, alpha: 1.0)

    static let blue = UIColor(red: 0.0 / 255.0, green:  122.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
}

class TriviaTableViewCell: UITableViewCell {

    static let identifier = "TriviaTableViewCellIdentifier"

    @IBOutlet private weak var difficultyLabel: UILabel!
    @IBOutlet private weak var questionLabel: UILabel!
    
    @IBOutlet private weak var answersView: UIView! {
        didSet {
            isFolded = true
        }
    }

    var isFolded: Bool = true {
        didSet {
            answersView.isHidden = isFolded
        }
    }

    @IBOutlet weak var answersStackView: UIStackView!

    private var answerButtons = [UIButton]()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

    func configure(with trivia: TriviaViewAdapted, andFoldedState isFolded: Bool) {
        difficultyLabel.text = trivia.difficulty
        questionLabel.text = trivia.question
        self.isFolded = isFolded
        add(answers: trivia.answers)
    }

    private func add(answers: [String]) {
        answerButtons.forEach {
            $0.removeFromSuperview()
        }

        for (id, answer) in answers.enumerated() {
            let answerButton = UIButton()
            answerButton.tag = id

            if id % 2 == 0 {
                answerButton.backgroundColor = TriviaColor.tealBlue
            } else {
                answerButton.backgroundColor = TriviaColor.blue
            }

            answerButton.setTitle(answer, for: .normal)
            answerButton.addTarget(self, action: #selector(touch(_:)), for: .touchUpInside)

            answerButtons.append(answerButton)
            answersStackView.addArrangedSubview(answerButton)
        }
    }

    @objc private func touch(_ button: UIButton) {
        print(button.tag)
    }

}
