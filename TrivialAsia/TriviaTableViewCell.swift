//
//  TriviaTableViewCell.swift
//  TrivialAsia
//
//  Created by Anastasia Stepanova-Kolupakhina on 27.05.17.
//  Copyright © 2017 Anastasia Kolupakhina. All rights reserved.
//

import UIKit

protocol TriviaTableViewCellDelegate: class {
    func isAnswer(_ answer: String, correctForTriviaWithId triviaId: Int) -> Bool
    func cellDidFinishWIthTrivia(withId triviaId: Int)
}

final class TriviaTableViewCell: UITableViewCell {

    static let identifier = "TriviaTableViewCell"
    static let cornerRadius: CGFloat = 4.0

    private var trivia: TriviaViewAdapted?
    private weak var delegate: TriviaTableViewCellDelegate?

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
        self.selectionStyle = .none

        difficultyLabel.layer.cornerRadius = TriviaTableViewCell.cornerRadius
        difficultyLabel.layer.masksToBounds = true
        difficultyLabel.backgroundColor = TriviaColor.pink

        difficultyLabel.textColor = .white
    }

    func configure(with trivia: TriviaViewAdapted, delegate: TriviaTableViewCellDelegate?, isFolded: Bool, isEven: Bool) {

        self.trivia = trivia
        self.delegate = delegate

        backgroundColor = isEven ? UIColor.white : TriviaColor.whiteSmoke
        difficultyLabel.text = " " + trivia.difficulty + " " // imitate UIEdgeInsets xD
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

            answerButton.layer.cornerRadius = TriviaTableViewCell.cornerRadius
            answerButton.layer.masksToBounds = true

            answerButton.setTitle(answer, for: .normal)
            answerButton.titleLabel?.font = UIFont.systemFont(ofSize: 15.0)
            answerButton.addTarget(self, action: #selector(touch(_:)), for: .touchUpInside)

            answerButtons.append(answerButton)
            answersStackView.addArrangedSubview(answerButton)
        }
    }

    @objc private func touch(_ button: UIButton) {
        guard let trivia = trivia else { return }
        guard let answerIsCorrect = delegate?.isAnswer(trivia.answers[button.tag], correctForTriviaWithId: trivia.id) else { return }

        answerButtons.forEach { $0.isUserInteractionEnabled = false }

        if answerIsCorrect {
            button.backgroundColor = TriviaColor.green
        } else {
            button.backgroundColor = TriviaColor.red
        }

        delegate?.cellDidFinishWIthTrivia(withId: trivia.id)
    }

}
