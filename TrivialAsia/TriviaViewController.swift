//
//  TriviaViewController.swift
//  TrivialAsia
//
//  Created by Anastasia Stepanova-Kolupakhina on 26.01.18.
//  Copyright © 2018 Anastasia Kolupakhina. All rights reserved.
//

import UIKit

class TriviaViewController: UIViewController, TriviaRoutable {
    var triviaFinishingHandler: ( (_ triviaId: Int?) -> () )?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        triviaFinishingHandler?(nil)
    }
}
