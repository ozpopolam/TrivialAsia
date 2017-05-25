//
//  TriviaMappable.swift
//  TrivialAsia
//
//  Created by Anastasia Stepanova-Kolupakhina on 25.05.17.
//  Copyright © 2017 Anastasia Kolupakhina. All rights reserved.
//

import Foundation
import ObjectMapper

protocol TriviaMappable: Mappable {
    var responseCode: Int { get set }
}
