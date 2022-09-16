//
//  AppDelegate.swift
//  RxWeather
//
//  Created by Дина Турман on 03.09.2022.
//

import UIKit
import RxSwift

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    private let disposeBag = DisposeBag()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:
                     [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        guard let window = window else { return false }

        window.rootViewController = navigationController
        appCoordinator = AppCoordinator(window: window,
                                        navigationController: navigationController,
                                        dependencies: WeatherAppDependencyContainer())
        appCoordinator?.start()
            .subscribe()
            .disposed(by: disposeBag)
        
        window.makeKeyAndVisible()
        window.backgroundColor = .systemBackground
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
        return true
    }
    
    private let navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.navigationBar.isTranslucent = false
        return navigationController
    }() 
}

