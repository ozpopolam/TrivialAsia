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
    func addTriviaAdaptedList(_ triviaAdaptedList: [TriviaAdapted])
    func showNotification(_ notification: String)
}

final class TriviaViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate let presenter = TriviaPresenter()
    
    fileprivate var triviaAdaptedList = [TriviaAdapted]()
    fileprivate var notification = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.attachView(view: self)
        presenter.getTriviaList()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.detachView()
    }

}

extension TriviaViewController: TriviaView {
    func addTriviaAdaptedList(_ triviaAdaptedList: [TriviaAdapted]) {
        notification = ""
        self.triviaAdaptedList.append(contentsOf: triviaAdaptedList)
        tableView.reloadData()
    }
    
    func showNotification(_ notification: String) {
        guard triviaAdaptedList.isEmpty else {
            return
        }
        self.notification = notification
        tableView.reloadData()
    }
}


extension TriviaViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if notification.isEmpty {
            return triviaAdaptedList.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if notification.isEmpty {
            return triviaCell(forRowAt: indexPath)
            
        } else {
            return notificationCell(forRowAt: indexPath)
        }
    }
    
    func triviaCell(forRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let trivia = triviaAdaptedList[indexPath.row]
        cell.textLabel?.text = trivia.question
        return cell
    }
    
    func notificationCell(forRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = notification
        return cell
    }
}

extension TriviaViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == triviaAdaptedList.count - 1 {
            presenter.getTriviaList()
        }
    }
}
