//
//  AlamofireExtension.swift
//  TrivialAsia
//
//  Created by Anastasia Stepanova-Kolupakhina on 28.05.17.
//  Copyright © 2017 Anastasia Kolupakhina. All rights reserved.
//

import Foundation
import Alamofire

final class AlamofireHelper {

    static func printOutcomingUrlRequest(_ urlRequest: URLRequest?) {
        var resultingString = "\n  ->  Alamofire is sending request"
        
        guard let urlRequest = urlRequest else {
            resultingString += "\n        info: no information about request"
            print(resultingString)
            return
        }
        resultingString += "\n        request: \(urlRequest)"
        resultingString += "\n"
        print(resultingString)
    }

    static func printIncomingUrlRequest(_ urlRequest: URLRequest?, withError error: TriviaError? = nil) {

        var resultingString = "\n  <-  Alamofire is receiving request"

        guard let urlRequest = urlRequest else {
            resultingString += "\n        info: no information about request"
            print(resultingString)
            return
        }

        resultingString += "\n        request: \(urlRequest)"

        if let error = error {
            resultingString += "\n        status: FAILURE - " + error.localizedDescription

        } else {
            resultingString += "\n        status: SUCCESS"
        }

        resultingString += "\n"
        
        print(resultingString)
    }

}
