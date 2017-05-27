//
//  TriviaTableViewCell.swift
//  TrivialAsia
//
//  Created by Anastasia Stepanova-Kolupakhina on 27.05.17.
//  Copyright © 2017 Anastasia Kolupakhina. All rights reserved.
//

import UIKit
enum TriviaColor {

    static let whiteSmoke = UIColor(red: 236.0 / 255.0,
                                    green: 236.0 / 255.0,
                                    blue: 236.0 / 255.0,
                                    alpha: 1.0)


    static let pink = UIColor(red: 255.0 / 255.0,
                              green: 45.0 / 255.0,
                              blue: 85.0 / 255.0,
                              alpha: 1.0)

//    static let orange = UIColor(red: 255.0 / 255.0, green:  149.0 / 255.0, blue: 0.0 / 255.0, alpha: 1.0)

    static let tealBlue = UIColor(red: 90.0 / 255.0,
                                  green: 200.0 / 255.0,
                                  blue: 250.0 / 255.0,
                                  alpha: 1.0)

    static let blue = UIColor(red: 0.0 / 255.0,
                              green:  122.0 / 255.0,
                              blue: 255.0 / 255.0,
                              alpha: 1.0)
}

class TriviaTableViewCell: UITableViewCell {

    static let identifier = "TriviaTableViewCellIdentifier"
    static let cornerRadius: CGFloat = 4.0

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

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

    func configure(with trivia: TriviaViewAdapted, isFolded: Bool, isEven: Bool) {
        backgroundColor = isEven ? UIColor.white : TriviaColor.whiteSmoke
        difficultyLabel.text = " " + trivia.difficulty + " " // imitate UIEdgeInsets xD
        questionLabel.text = trivia.question
        self.isFolded = isFolded
        add(answers: trivia.answers)


        if let indexPath = (superview as? UITableView)?.indexPath(for: self) {
            print(indexPath.row)
        }
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
        print(button.tag)
    }

}
