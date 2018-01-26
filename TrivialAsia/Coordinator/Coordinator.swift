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
    func provideTriviaListRoutable() -> Routable
}

// implementations

final class ApplicationCoordinatorProvider: CoordinatorProvider {
    func provideTriviaListCoordinator(withRouter router: Router,
                                      andRouteProvider routeProvider: RouteProvider) -> Coordinator {
        return TriviaListCoordinator(withRouter: router, andRouteProvider: routeProvider)
    }
}

final class ApplicationRouteProvider: RouteProvider {
    func provideTriviaListRoutable() -> Routable {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)

        let triviaListRoute = mainStoryboard.instantiateViewController(withIdentifier: "TriviaViewController") as! TriviaViewController
        return triviaListRoute
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
        let triviaListRoute = routeProvider.provideTriviaListRoutable()
        router.route(viewController: triviaListRoute.viewController, withOption: routingOption)
    }
}

/// /// ///

class ApplicationCoordinator: Coordinator {
    private let coordinatorProvider: CoordinatorProvider
    private let router: Router

    private let routeProvider: RouteProvider

    init(coordinatorProvider: CoordinatorProvider, router: Router) {
        self.coordinatorProvider = coordinatorProvider
        self.router = router

        routeProvider = ApplicationRouteProvider()
    }

    func start(withRoutingOption routingOption: RoutingOption) {
        let triviaListCoordinator = coordinatorProvider.provideTriviaListCoordinator(withRouter: router,
                                                                                     andRouteProvider: routeProvider)
        triviaListCoordinator.start(withRoutingOption: routingOption)
    }
}
