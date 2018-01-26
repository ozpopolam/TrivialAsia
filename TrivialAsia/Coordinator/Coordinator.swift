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
    func start(withRoutingOption routingOption: RoutingOption)
}

protocol CoordinatorProvider {
    func provideTriviaListCoordinator(withRouter router: Router, andRouteProvider routeProvider: RouteProvider) -> Coordinator
}



protocol RouteProvider {
    func provideTriviaNavigationRoutable() -> Routable
    func provideTriviaListRoutable() -> TriviaListRoutable
    func provideTriviaRoutable() -> TriviaRoutable
}

// implementations

final class ApplicationCoordinatorProvider: CoordinatorProvider {
    func provideTriviaListCoordinator(withRouter router: Router,
                                      andRouteProvider routeProvider: RouteProvider) -> Coordinator {
        return TriviaListCoordinator(withRouter: router, andRouteProvider: routeProvider)
    }
}

protocol TriviaListRoutable: Routable {
    var triviaSelectionHandler: ( (_ triviaId: Int) -> () )? { get set }
}

protocol TriviaRoutable: Routable {
    var triviaFinishingHandler: ( (_ triviaId: Int?) -> () )? { get set }
}

final class ApplicationRouteProvider: RouteProvider {
    func provideTriviaNavigationRoutable() -> Routable {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let triviaNavigationRoute = mainStoryboard.instantiateViewController(withIdentifier: "TriviaNavigationController")
        return triviaNavigationRoute
    }

    func provideTriviaListRoutable() -> TriviaListRoutable {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let triviaListRoute = mainStoryboard.instantiateViewController(withIdentifier: "TriviaListViewController") as! TriviaListViewController
        return triviaListRoute
    }

    func provideTriviaRoutable() -> TriviaRoutable {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let triviaRoute = mainStoryboard.instantiateViewController(withIdentifier: "TriviaViewController") as! TriviaViewController
        return triviaRoute
    }
}



final class TriviaListCoordinator: Coordinator {
    private let router: Router
    private let routeProvider: RouteProvider

    init(withRouter router: Router, andRouteProvider routeProvider: RouteProvider) {
        self.router = router
        self.routeProvider = routeProvider
    }

    func start(withRoutingOption routingOption: RoutingOption) {
        let triviaNavigationRoute = routeProvider.provideTriviaNavigationRoutable()
        router.route(viewController: triviaNavigationRoute.viewController, withOption: routingOption)

        var triviaListRoute = routeProvider.provideTriviaListRoutable()
        triviaListRoute.triviaSelectionHandler = { [weak self] (triviaId) in
            guard let strongSelf = self else { return }
            strongSelf.coordinateToTrivia()
        }

        router.route(viewController: triviaListRoute.viewController, withOption: .set(viewControllers: [triviaListRoute.viewController]))
    }

    private func coordinateToTrivia() {
        var triviaRoute = routeProvider.provideTriviaRoutable()
        triviaRoute.triviaFinishingHandler = { [weak self] (triviaId) in
            guard let strongSelf = self else { return }
            print(triviaId)
        }
        router.route(viewController: triviaRoute.viewController, withOption: .push)
    }
}

/// /// ///

class ApplicationCoordinator: Coordinator {
    private let coordinatorProvider: CoordinatorProvider
    private let router: Router

    private let routeProvider: RouteProvider

    var coordinators = [Coordinator]()

    init(coordinatorProvider: CoordinatorProvider, router: Router) {
        self.coordinatorProvider = coordinatorProvider
        self.router = router

        routeProvider = ApplicationRouteProvider()
    }

    func start(withRoutingOption routingOption: RoutingOption) {
        let triviaListCoordinator = coordinatorProvider.provideTriviaListCoordinator(withRouter: router,
                                                                                     andRouteProvider: routeProvider)
        triviaListCoordinator.start(withRoutingOption: routingOption)
        coordinators.append(triviaListCoordinator)
    }
}
