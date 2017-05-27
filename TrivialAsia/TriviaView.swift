//
//  TriviaView.swift
//  TrivialAsia
//
//  Created by Anastasia Stepanova-Kolupakhina on 26.05.17.
//  Copyright © 2017 Anastasia Kolupakhina. All rights reserved.
//

import Foundation

protocol TriviaView: class {
    func addTriviaAdaptedList(_ triviaAdaptedList: [TriviaViewAdapted])
    func showNotification(_ notificationText: String)
}
