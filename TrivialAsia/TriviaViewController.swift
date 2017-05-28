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
    fileprivate var viewState = TriviaViewState.notification(TriviaViewNotification.isBeingLoaded)
    fileprivate let timeBeforeFinishingWithTrivia: TimeInterval = 0.75

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension

        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 100
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
        let cell = tableView.dequeueReusableCell(withIdentifier: TriviaTableViewCell.identifier, for: indexPath) as! TriviaTableViewCell
        cell.configure(with: trivia, isFolded: true, isEven: indexPath.row % 2 == 0)
        cell.delegate = self
        return cell
    }

    func notificationCell(fromText text: String, forRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TriviaTableViewCell.identifier, for: indexPath) as! TriviaTableViewCell
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? TriviaTableViewCell {
            tableView.beginUpdates()

            UIView.animate(withDuration: 0.3) {
                cell.isFolded = !cell.isFolded
            }

            tableView.endUpdates()
            return
        }
    }
}

extension TriviaViewController: TriviaTableViewCellDelegate {
    func isAnswer(_ answer: String, correctForTriviaWithId triviaId: Int) -> Bool {
        return presenter.isAnswer(answer, correctForTriviaWithId: triviaId)
    }

    func cellDidFinishWIthTrivia(withId triviaId: Int) {
        view.isUserInteractionEnabled = false

        DispatchQueue.main.asyncAfter(deadline: .now() + self.timeBeforeFinishingWithTrivia) {

            guard case .triviaAdaptedList(var list) = self.viewState else { return }
            guard let index = list.index(where: { $0.id == triviaId }) else { return }

            list.remove(at: index)
            self.viewState = .triviaAdaptedList(list)
            self.presenter.finishWIthTrivia(withId: triviaId)
            
            self.tableView.reloadData()
            self.view.isUserInteractionEnabled = true
        }
    }
}
