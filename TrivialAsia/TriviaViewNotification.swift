//
//  TriviaViewNotification.swift
//  TrivialAsia
//
//  Created by Anastasia Stepanova-Kolupakhina on 25.05.17.
//  Copyright © 2017 Anastasia Kolupakhina. All rights reserved.
//

import Foundation

enum TriviaViewNotification: String {
    case isBeingLoaded = "Trivia is being loaded..."
    case sorryNoTrivia = "Sorry! No trivia today"
    case checkInternetConnection = "No Internet! Please, check your connection"
}
