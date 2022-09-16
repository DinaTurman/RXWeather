//
//  WeatherAppDependencyContainer.swift
//  RxWeather
//
//  Created by Дина Турман on 14.09.2022.
//

import UIKit

final class WeatherAppDependencyContainer {
    let sharedNetwork: Network
    
    init() {
        func makeNetwork() -> Network { return Network() }
        
        self.sharedNetwork = makeNetwork()
    }
    
    func makeWeatherService() -> WeatherService {
        return WeatherService(client: sharedNetwork)
    }
    
    func makeWeatherViewModelFactory() -> WeatherViewModel {
        return WeatherViewModel(serviceFactory: self)
    }
}

extension WeatherAppDependencyContainer: WeatherViewModelFactory, WeatherServiceFactory {}
