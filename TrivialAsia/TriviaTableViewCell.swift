//
//  TriviaTableViewCell.swift
//  TrivialAsia
//
//  Created by Anastasia Stepanova-Kolupakhina on 27.05.17.
//  Copyright © 2017 Anastasia Kolupakhina. All rights reserved.
//

import UIKit

class TriviaTableViewCell: UITableViewCell {

    static let identifier = "TriviaTableViewCellIdentifier"

    @IBOutlet private weak var difficultyLabel: UILabel!
    @IBOutlet private weak var questionLabel: UILabel!
    
    @IBOutlet private weak var answersView: UIView! {
        didSet {
            answersView.isHidden = true
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

        for answer in answers {
            let answerButton = UIButton()
            answerButton.setTitle(answer, for: .normal)
            answerButtons.append(answerButton)
            answersStackView.addArrangedSubview(answerButton)
        }
    }

}
