//
//  Router.swift
//  TrivialAsia
//
//  Created by Anastasia Stepanova-Kolupakhina on 25.01.18.
//  Copyright © 2018 Anastasia Kolupakhina. All rights reserved.
//

import UIKit

protocol Router {
    func route(viewController: UIViewController, withOption option: RoutingOption)
}

enum RoutingOption {
    case setRoot(toWindow: UIWindow?)
    case push
    case present
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
    var topViewController: UIViewController?

    func route(viewController: UIViewController, withOption option: RoutingOption) {
        switch option {
        case .present:
            break

        case .push:
            break

        case .setRoot(let window):
            self.rootViewController = viewController
            self.topViewController = viewController
            window?.rootViewController = viewController
        }

        // if setRoot

    }

    init() {
        rootViewController = UIViewController()
        rootViewController?.view.backgroundColor = .red

        topViewController = rootViewController
    }

    func setRootViewController(to window: UIWindow?) {
        window?.rootViewController = rootViewController
    }

    func push(viewController: UIViewController) {
        guard let navigationController = topViewController as? UINavigationController else { return }
        navigationController.pushViewController(viewController, animated: true)
    }

    func present(viewController: UIViewController) {
        guard let topViewController = topViewController else { return }
        topViewController.present(viewController, animated: true, completion: nil)
    }
}


//window.rootViewController = myViewController;
//In rare cases you might want to create your app’s window programmatically. You would use code something like this to programmatically create a window, install the root view controller, and make the window visible:
//
//- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    myViewController = [[MyViewController alloc] init];
//    window.rootViewController = myViewController;
//    [window makeKeyAndVisible];
//    return YES;
//}

