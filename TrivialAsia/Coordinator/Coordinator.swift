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

//extension UIViewController: Routable {
//
//}


//
//protocol CoordinatorProvider {
//    func provideTriviaListCoordinator(withRouter router: Router, andRouteProvider routeProvider: RouteProvider) -> Coordinator
//}

//protocol RouteProvider {
//    func provideTriviaNavigationRoutable() -> Routable
//    func provideTriviaListRoutable() -> TriviaListRoutable
//    func provideTriviaRoutable() -> TriviaRoutable
//}
//
//// implementations
//
//final class ApplicationCoordinatorProvider: CoordinatorProvider {
//    func provideTriviaListCoordinator(withRouter router: Router,
//                                      andRouteProvider routeProvider: RouteProvider) -> Coordinator {
//        return TriviaListCoordinator(withRouter: router, andRouteProvider: routeProvider)
//    }
//}

//protocol TriviaListRoutable: Routable {
//    var triviaSelectionHandler: ( (_ triviaId: Int) -> () )? { get set }
//}
//
//protocol TriviaRoutable: Routable {
//    var triviaFinishingHandler: ( (_ triviaId: Int?) -> () )? { get set }
//}

//final class ApplicationRouteProvider: RouteProvider {
//    func provideTriviaNavigationRoutable() -> Routable {
//        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let triviaNavigationRoute = mainStoryboard.instantiateViewController(withIdentifier: "TriviaNavigationController")
//        return triviaNavigationRoute
//    }
//
//    func provideTriviaListRoutable() -> TriviaListRoutable {
//        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let triviaListRoute = mainStoryboard.instantiateViewController(withIdentifier: "TriviaListViewController") as! TriviaListViewController
//        return triviaListRoute
//    }
//
//    func provideTriviaRoutable() -> TriviaRoutable {
//        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let triviaRoute = mainStoryboard.instantiateViewController(withIdentifier: "TriviaViewController") as! TriviaViewController
//        return triviaRoute
//    }
//}

final class TriviaListRouter {
    private var rootViewController: UIViewController?
    private var topViewController: UIViewController?

    func set(rootViewController: UIViewController?) {
        self.rootViewController = rootViewController
    }

    func set(viewControllers: [UIViewController]) {
        guard let rootViewController = rootViewController as? UINavigationController else { return }
        rootViewController.setViewControllers(viewControllers, animated: false)
    }

//    func route(viewController: UIViewController, withOption option: RoutingOption) {
//        switch option {
//        case .present:
//            guard let topViewController = topViewController else { return }
//            topViewController.present(viewController, animated: true, completion: nil)
//
//            self.topViewController = viewController
//
//
//        case .push:
//            guard let topViewController = topViewController as? UINavigationController else { return }
//            topViewController.pushViewController(viewController, animated: true)
//
//        case .setRoot(let window):
//            rootViewController = viewController
//            topViewController = viewController
//
//            window?.rootViewController = viewController
//
//        case .set(let viewControllers):
//            guard let topViewController = topViewController as? UINavigationController else { return }
//            topViewController.setViewControllers(viewControllers, animated: false)
//
//        }
//    }
}

final class TriviaListRouteAssembler {
    func assembleListNavigation() -> Routable {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let listNavigationRoute = mainStoryboard.instantiateViewController(withIdentifier: "TriviaNavigationController")
        return listNavigationRoute
    }

    func assembleList() -> Routable {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let listRoute = mainStoryboard.instantiateViewController(withIdentifier: "TriviaListViewController") as! TriviaListViewController
        return listRoute
    }
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
        let listRoute = assembler.assembleList()
        router.set(viewControllers: [listRoute.viewController])
    }

//    func start(withRoutingOption routingOption: RoutingOption) {
//        let navigationRoute = assembler.assembleTriviaNavigation()
//        let triviaNavigationRoute = routeProvider.provideTriviaNavigationRoutable()
//        router.route(viewController: triviaNavigationRoute.viewController, withOption: routingOption)
//
//        var triviaListRoute = routeProvider.provideTriviaListRoutable()
//        triviaListRoute.triviaSelectionHandler = { [weak self] (triviaId) in
//            guard let strongSelf = self else { return }
//            strongSelf.coordinateToTrivia()
//        }
//
//        router.route(viewController: triviaListRoute.viewController, withOption: .set(viewControllers: [triviaListRoute.viewController]))
//    }
//
//    private func coordinateToTrivia() {
//        var triviaRoute = routeProvider.provideTriviaRoutable()
//        triviaRoute.triviaFinishingHandler = { [weak self] (triviaId) in
//            guard let strongSelf = self else { return }
//            print(triviaId)
//        }
//        router.route(viewController: triviaRoute.viewController, withOption: .push)
//    }
}

/// /// ///

class AppCoordinator {
    private weak var appWindow: UIWindow?

    init(with appWindow: UIWindow?) {
        self.appWindow = appWindow
    }

    func start() {
        let triviaListCoordinator = TriviaListCoordinator()
        appWindow?.rootViewController = triviaListCoordinator.start()
    }
}

//class AppRouter {
//
//}

//class ApplicationCoordinator: Coordinator {
//    private let coordinatorProvider: CoordinatorProvider
//    private let router: Router
//
//    private let routeProvider: RouteProvider
//
//    var coordinators = [Coordinator]()
//
//    init(coordinatorProvider: CoordinatorProvider, router: Router) {
//        self.coordinatorProvider = coordinatorProvider
//        self.router = router
//
//        routeProvider = ApplicationRouteProvider()
//    }
//
//    func start(withRoutingOption routingOption: RoutingOption) {
//        let triviaListCoordinator = coordinatorProvider.provideTriviaListCoordinator(withRouter: router,
//                                                                                     andRouteProvider: routeProvider)
//        triviaListCoordinator.start(withRoutingOption: routingOption)
//        coordinators.append(triviaListCoordinator)
//    }
//}

