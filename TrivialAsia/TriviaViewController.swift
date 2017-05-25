//
//  ViewController.swift
//  TrivialAsia
//
//  Created by Anastasia Stepanova-Kolupakhina on 25.05.17.
//  Copyright © 2017 Anastasia Kolupakhina. All rights reserved.
//

import UIKit
import Alamofire

protocol TriviaView: class {
    //func showLoader()
    func addTriviaAdaptedList(_ triviaAdaptedList: [TriviaAdapted])
}

final class TriviaViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate let presenter = TriviaPresenter()
    
    fileprivate var triviaAdaptedList = [TriviaAdapted]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.dataSource = self
        tableView.delegate = self
        
        presenter.attachView(view: self)
        presenter.getTriviaList()
    }
    
    func printTrivia(list: [Trivia]) {
        for trivia in list {
            print(trivia.question)
        }
    }

}

extension TriviaViewController: TriviaView {
    func addTriviaAdaptedList(_ triviaAdaptedList: [TriviaAdapted]) {
        self.triviaAdaptedList.append(contentsOf: triviaAdaptedList)
        tableView.reloadData()
    }
}


extension TriviaViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return triviaAdaptedList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let trivia = triviaAdaptedList[indexPath.row]
        cell.textLabel?.text = trivia.question
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == triviaAdaptedList.count - 1 {
            presenter.getTriviaList()
        }
        
    }
    
}

extension TriviaViewController: UITableViewDelegate {
    

    
}
