//
//  ViewController.swift
//  TrivialAsia
//
//  Created by Anastasia Stepanova-Kolupakhina on 25.05.17.
//  Copyright © 2017 Anastasia Kolupakhina. All rights reserved.
//

import UIKit
import Alamofire

final class TriviaListViewController: UIViewController {
    var triviaSelectionHandler: ( (_ triviaId: Int) -> () )?

    @IBOutlet weak var tableView: UITableView!
    
    fileprivate let presenter = TriviaPresenter()
    fileprivate var viewState = TriviaViewState.notification(TriviaViewNotification.isBeingLoaded)
    fileprivate let timeBeforeFinishingWithTrivia: TimeInterval = 0.75
    fileprivate let foldingTime: TimeInterval = 0.3

    fileprivate var unfoldedTriviaIds = Set<Int>()

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

extension TriviaListViewController: UITableViewDataSource {
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

        let isFolded = !unfoldedTriviaIds.contains(trivia.id)
        cell.configure(with: trivia, delegate: self, isFolded: isFolded, isEven: indexPath.row % 2 == 0)

        return cell
    }

    func notificationCell(fromText text: String, forRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NotificationTableViewCell.identifier, for: indexPath) as! NotificationTableViewCell
        cell.configure(withNotificationText: text)
        return cell
    }
}

extension TriviaListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard case .triviaAdaptedList(let list) = viewState else { return }
        if indexPath.row == list.count - 1 {
            presenter.getTriviaList()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard case .triviaAdaptedList(let list) = viewState else { return }
        guard let cell = tableView.cellForRow(at: indexPath) as? TriviaTableViewCell else { return }

        let triviaId = list[indexPath.row].id
        triviaSelectionHandler?(triviaId)

            tableView.beginUpdates()

            UIView.animate(withDuration: foldingTime) {
                cell.isFolded = !cell.isFolded

                let triviaId = list[indexPath.row].id
                if cell.isFolded {
                    self.unfoldedTriviaIds.remove(triviaId)
                } else {
                    self.unfoldedTriviaIds.insert(triviaId)
                }
            }

            tableView.endUpdates()
            return

    }
}

extension TriviaListViewController: TriviaTableViewCellDelegate {
    func isAnswer(_ answer: String, correctForTriviaWithId triviaId: Int) -> Bool {
        return presenter.isAnswer(answer, correctForTriviaWithId: triviaId)
    }

    func cellDidFinishWIthTrivia(withId triviaId: Int) {
        view.isUserInteractionEnabled = false

        DispatchQueue.main.asyncAfter(deadline: .now() + self.timeBeforeFinishingWithTrivia) {

            guard case .triviaAdaptedList(var list) = self.viewState else { return }
            guard let row = list.index(where: { $0.id == triviaId }) else { return }

            list.remove(at: row)
            self.viewState = .triviaAdaptedList(list)

            self.unfoldedTriviaIds.remove(triviaId)

            self.presenter.finishWIthTrivia(withId: triviaId)
            
            self.tableView.reloadData()
            self.view.isUserInteractionEnabled = true
        }
    }
}

extension TriviaListViewController: TriviaView {
    func addTriviaAdaptedList(_ triviaAdaptedList: [TriviaViewAdapted]) {
        if case .triviaAdaptedList(var list) = viewState {
            list.append(contentsOf: triviaAdaptedList)
            viewState = .triviaAdaptedList(list)

        } else {
            viewState = .triviaAdaptedList(triviaAdaptedList)
        }

        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func showNotification(_ notificationText: String) {
        guard case .notification(_) = viewState else { return }
        viewState = .notification(notificationText)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
