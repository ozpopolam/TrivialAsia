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
    }

    func configure(withNotificationText notificationText: String) {
        notificationLabel.text = notificationText
    }
}
