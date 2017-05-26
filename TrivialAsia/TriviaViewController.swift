//
//  ViewController.swift
//  TrivialAsia
//
//  Created by Anastasia Stepanova-Kolupakhina on 25.05.17.
//  Copyright © 2017 Anastasia Kolupakhina. All rights reserved.
//

import UIKit
import Alamofire



final class TriviaViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate let presenter = TriviaPresenter()
    fileprivate var viewState = TriviaViewState.notification(TriviaViewNotification.isBeingLoaded.rawValue)

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

extension TriviaViewController: TriviaViewProtocol {
    func addTriviaAdaptedList(_ triviaAdaptedList: [TriviaViewAdapted]) {
        if case .triviaAdaptedList(var list) = viewState {
            list.append(contentsOf: triviaAdaptedList)
            viewState = .triviaAdaptedList(list)

        } else {
            viewState = .triviaAdaptedList(triviaAdaptedList)
        }

        tableView.reloadData()
    }
    
    func showNotification(_ notificationText: String) {
        guard case .notification(_) = viewState else { return }
        viewState = .notification(notificationText)
        tableView.reloadData()
    }
}

extension TriviaViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch viewState {
        case .notification:
            return 1

        case .triviaAdaptedList(let list):
            return list.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewState {
        case .notification(let text):
            return notificationCell(fromText: text, forRowAt: indexPath)

        case .triviaAdaptedList(let list):
            return triviaCell(fromTrivia: list[indexPath.row], forRowAt: indexPath)
        }
    }
    
    func triviaCell(fromTrivia trivia: TriviaViewAdapted, forRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = trivia.question
        return cell
    }
    
    func notificationCell(fromText text: String, forRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = text
        return cell
    }
}

extension TriviaViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard case .triviaAdaptedList(let list) = viewState else { return }
        if indexPath.row == list.count - 1 {
            presenter.getTriviaList()
        }
    }
}
