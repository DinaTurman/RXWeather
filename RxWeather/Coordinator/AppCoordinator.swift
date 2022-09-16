//
//  AppCoordinator.swift
//  RxWeather
//
//  Created by Дина Турман on 14.09.2022.
//

import UIKit
import RxSwift

final class AppCoordinator: Coordinator<Void> {
    private let navigationController: UINavigationController
    private let window: UIWindow
    let dependencies: WeatherAppDependencyContainer
    
    init(window: UIWindow,
         navigationController: UINavigationController,
         dependencies: WeatherAppDependencyContainer) {
        self.window = window
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    override func start() -> Observable<Void> {
        // Show Weather  screen
        return showWeather()
    }
    
    private func showWeather() -> Observable<Void> {
        let rootCoordinator = RootCoordinator(navigationController: navigationController,
                                              dependencies: self.dependencies)
        return coordinate(to: rootCoordinator)
    }
    
}

final class RootCoordinator: Coordinator<Void>{
    private let rootNavigationController:UINavigationController
    private let dependencies: WeatherAppDependencyContainer

    init(navigationController:UINavigationController,
         dependencies: WeatherAppDependencyContainer) {
        self.rootNavigationController = navigationController
        self.dependencies = dependencies
    }

    override func start() -> Observable<CoordinationResult> {
        let viewController = WeatherViewController(viewModelFactory: dependencies)

        rootNavigationController.pushViewController(viewController, animated: true)
        return Observable.never()
    }
}
