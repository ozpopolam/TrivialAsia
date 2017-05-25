//
//  ResponseCode.swift
//  TrivialAsia
//
//  Created by Anastasia Stepanova-Kolupakhina on 25.05.17.
//  Copyright © 2017 Anastasia Kolupakhina. All rights reserved.
//

import Foundation

enum ResponseCode: Int {
    case noCode = -1
    case success = 0
    case noResults
    case invalidParameter
    case tokenNotFound
    case tokenEmpty
}
