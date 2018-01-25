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

//protocol ApplicationCoordinator: class {
//    func start(with )
//}

protocol CoordinatorProvider {
    func provideTriviaListCoordinator(withRouter router: Router, andRouteProvider routeProvider: RouteProvider) -> Coordinator
}

protocol RouteProvider {
    func provideTriviaListRoute() -> UIViewController
}

protocol TriviaListRoute: Route {
}

// implementations

final class ApplicationCoordinatorProvider: CoordinatorProvider {
    func provideTriviaListCoordinator(withRouter router: Router,
                                      andRouteProvider routeProvider: RouteProvider) -> Coordinator {
        return TriviaListCoordinator(withRouter: router, andRouteProvider: routeProvider)
    }
}

final class DefaultRouteProvider: RouteProvider {
    func provideTriviaListRoute() -> UIViewController {
        let triviaListRoute = UIViewController()
        triviaListRoute.view.backgroundColor = .yellow
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
        let triviaListRoute = routeProvider.provideTriviaListRoute()
        router.route(viewController: triviaListRoute, withOption: routingOption)
    }

    func start() {
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

        routeProvider = DefaultRouteProvider()
    }

    func start(withRoutingOption routingOption: RoutingOption) {
        let triviaListCoordinator = coordinatorProvider.provideTriviaListCoordinator(withRouter: router,
                                                                                     andRouteProvider: routeProvider)
        triviaListCoordinator.start(withRoutingOption: routingOption)
    }
}
