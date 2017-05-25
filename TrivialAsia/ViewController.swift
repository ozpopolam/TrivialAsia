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
        
        let urlRequest = TriviaAPIRouter.getTrivia(withAmount: 10, andToken: nil)
        
        print(urlRequest.url.absoluteString)
        
        Alamofire.request(urlRequest)
            .responseTrivia { (response: DataResponse<TriviaListResponse>) in
                
                if let value = response.result.value {
                    print("asd")
                }
                
                
                
                
        }
    }

}
