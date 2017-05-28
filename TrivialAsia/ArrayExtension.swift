//
//  ArrayExtension.swift
//  TrivialAsia
//
//  Created by Anastasia Stepanova-Kolupakhina on 28.05.17.
//  Copyright © 2017 Anastasia Kolupakhina. All rights reserved.
//

import Foundation

extension Array {
    mutating func shuffle(withStubbornnessLevel level: Int) {
        guard count > 1 else { return }

        for _ in 0..<level {
            sort { (_, _) -> Bool in
                return arc4random() < arc4random()
            }
        }
    }
}
