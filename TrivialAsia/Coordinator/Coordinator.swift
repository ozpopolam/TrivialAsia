//
//  Coordinator.swift
//  TrivialAsia
//
//  Created by Anastasia Stepanova-Kolupakhina on 25.01.18.
//  Copyright © 2018 Anastasia Kolupakhina. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator: class {
    func start() -> UIViewController
}

protocol Transition: class {
    func open(_ transitioningViewController: UIViewController) -> UIViewController?
}

//final class PresentTransition: Transition {
//    weak var viewController: UIViewController?
//
//    init(with viewController: UIViewController) {
//        self.viewController = viewController
//    }
//
//    func open(_ transitioningViewController: UIViewController) -> UIViewController? {
//        viewController?.present(transitioningViewController, animated: true, completion: nil)
//        return transitioningViewController
//    }
//}

//final class ShowTransition: Transition {
//    private weak var navigationController: UINavigationController?
//
//    init?(with router: Router) {
//        guard let navigationController = router.rootViewController as? UINavigationController else {
//            return nil
//        }
//        self.navigationController = navigationController
//    }
//
//    func open(_ transitioningViewController: UIViewController) -> UIViewController? {
//        return nil
//    }
//
//    func close() -> UIViewController? {
//        return nil
//    }
//}

final class SetTransition: Transition {
    private weak var navigationController: UINavigationController?

    init?(with router: Router) {
        guard let navigationController = router.rootViewController as? UINavigationController else {
            return nil
        }
        self.navigationController = navigationController
    }

    func open(_ transitioningViewController: UIViewController) -> UIViewController? {
        navigationController?.setViewControllers([transitioningViewController], animated: false)
        return navigationController
    }

    func close() -> UIViewController? {
        return nil
    }
}

protocol Router {
    weak var rootViewController: UIViewController? { get }
    weak var topViewController: UIViewController? { get }

    func route(to viewController: UIViewController, with transition: Transition)
}

final class TriviaListRouter: Router {
    private(set) weak var rootViewController: UIViewController?
    private(set) weak var topViewController: UIViewController?

    func set(rootViewController: UIViewController?) {
        self.rootViewController = rootViewController
    }

    func route(to viewController: UIViewController, with transition: Transition) {
        topViewController = transition.open(viewController)
    }
}

final class TriviaListRouteAssembler {
    func assembleListNavigation() -> Routable {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let listNavigationRoute = mainStoryboard.instantiateViewController(withIdentifier: "TriviaNavigationController")
        return listNavigationRoute
    }

    func assembleList(withCoordinatorInput coordinatorInput: TriviaListCoordinatorInput) -> Routable {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let listRoute = mainStoryboard.instantiateViewController(withIdentifier: "TriviaListViewController") as! TriviaListViewController

        listRoute.coordinatorInput = coordinatorInput

        return listRoute
    }
}

protocol TriviaListCoordinatorInput: class {
    func triviaListDidSelect(triviaWithId triviaId: Int)
}

final class TriviaListCoordinator: Coordinator {
    private let assembler = TriviaListRouteAssembler()
    private let router = TriviaListRouter()

    init() { }

    func start() -> UIViewController {
        let listNavigationRoute = assembler.assembleListNavigation()
        router.set(rootViewController: listNavigationRoute.viewController)

        coordinateToList()

        return listNavigationRoute.viewController
    }

    private func coordinateToList() {
        let listRoute = assembler.assembleList(withCoordinatorInput: self)

        guard let transition = SetTransition(with: router) else { return }
        router.route(to: listRoute.viewController, with: transition)
    }

    fileprivate func coordinateToTrivia(withId triviaId: Int) {
        print(triviaId)
        print()
    }
}

extension TriviaListCoordinator: TriviaListCoordinatorInput {
    func triviaListDidSelect(triviaWithId triviaId: Int) {
        coordinateToTrivia(withId: triviaId)
    }
}

class AppCoordinator {
    private weak var appWindow: UIWindow?

    var coordinators = [Coordinator]()

    init(with appWindow: UIWindow?) {
        self.appWindow = appWindow
    }

    func start() {
        let triviaListCoordinator = TriviaListCoordinator()
        coordinators.append(triviaListCoordinator)
        appWindow?.rootViewController = triviaListCoordinator.start()
    }
}
