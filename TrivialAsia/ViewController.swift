//
//  ViewController.swift
//  TrivialAsia
//
//  Created by Anastasia Stepanova-Kolupakhina on 25.05.17.
//  Copyright © 2017 Anastasia Kolupakhina. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        TriviaService().getTriviaList(withAmount: 15) { completionHandler in
            
            if let value = completionHandler.value {
                print(value)
            } else {
                print(completionHandler.error)
            }
            
        }
    }

}
