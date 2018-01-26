//
//  Router.swift
//  TrivialAsia
//
//  Created by Anastasia Stepanova-Kolupakhina on 25.01.18.
//  Copyright © 2018 Anastasia Kolupakhina. All rights reserved.
//

import UIKit

protocol Identifiable {
    var identifier: String { get }
}

extension Identifiable {
    var identifier: String {
        return String(describing: self)
    }
}

protocol Routable {
    var viewController: UIViewController { get }
}

extension UIViewController: Routable {
    var viewController: UIViewController {
        return self
    }
}

protocol Router {
    func route(viewController: UIViewController, withOption option: RoutingOption)
}

enum RoutingOption {
    case setRoot(toWindow: UIWindow?)
    case push
    case present
    case set(viewControllers: [UIViewController])

}

protocol Route {
    var controller: UIViewController? { get }
}

extension UIViewController: Route {
    var controller: UIViewController? {
        return self
    }
}

final class ApplicationRouter: Router {
    private var rootViewController: UIViewController?
    private var topViewController: UIViewController?

    func route(viewController: UIViewController, withOption option: RoutingOption) {
        switch option {
        case .present:
            guard let topViewController = topViewController else { return }
            topViewController.present(viewController, animated: true, completion: nil)

            self.topViewController = viewController

        case .push:
            guard let topViewController = topViewController as? UINavigationController else { return }
            topViewController.pushViewController(viewController, animated: true)

        case .setRoot(let window):
            rootViewController = viewController
            topViewController = viewController

            window?.rootViewController = viewController

        case .set(let viewControllers):
            guard let topViewController = topViewController as? UINavigationController else { return }
            topViewController.setViewControllers(viewControllers, animated: false)

        }
    }
}
