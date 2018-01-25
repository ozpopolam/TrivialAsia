//
//  AppDelegate.swift
//  TrivialAsia
//
//  Created by Anastasia Stepanova-Kolupakhina on 25.05.17.
//  Copyright © 2017 Anastasia Kolupakhina. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    private lazy var coordinator = ApplicationCoordinator(coordinatorProvider: ApplicationCoordinatorProvider(),
                                                          router: ApplicationRouter())

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        coordinator.start(withRoutingOption: .setRoot(toWindow: window))
        return true
    }
}
