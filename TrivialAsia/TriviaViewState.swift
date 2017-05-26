//
//  TriviaViewState.swift
//  TrivialAsia
//
//  Created by Anastasia Stepanova-Kolupakhina on 26.05.17.
//  Copyright © 2017 Anastasia Kolupakhina. All rights reserved.
//

import Foundation

enum TriviaViewState {
    case notification(String)
    case triviaAdaptedList([TriviaViewAdapted])
}
