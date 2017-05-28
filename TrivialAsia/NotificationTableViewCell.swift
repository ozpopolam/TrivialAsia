//
//  NotificationTableViewCell.swift
//  TrivialAsia
//
//  Created by Anastasia Stepanova-Kolupakhina on 28.05.17.
//  Copyright © 2017 Anastasia Kolupakhina. All rights reserved.
//

import UIKit

final class NotificationTableViewCell: UITableViewCell {

    static let identifier = "NotificationTableViewCell"
    static let cornerRadius: CGFloat = 4.0

    @IBOutlet private weak var notificationLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none

//        difficultyLabel.layer.cornerRadius = TriviaTableViewCell.cornerRadius
//        difficultyLabel.layer.masksToBounds = true
//        difficultyLabel.backgroundColor = TriviaColor.pink
//
//        difficultyLabel.textColor = .white
    }

    func configure(withNotificationText notificationText: String) {
        notificationLabel.text = notificationText
    }
}
