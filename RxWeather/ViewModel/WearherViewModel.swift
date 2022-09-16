//
//  WearherViewModel.swift
//  RxWeather
//
//  Created by Дина Турман on 10.09.2022.
//


import UIKit
import RxSwift
import RxRelay

final class WeatherViewModel {
    let cityName: Observable<String>
    let temperature: Observable<String>
    let weatherDescription: Observable<String>
    let maxMinTemperature: Observable<String>
    let iconWeather: Observable<String>
    
    let searchText = BehaviorRelay(value: "")
    
    private let disposeBag = DisposeBag()
    private let weather: Observable<WeatherModel>


    //MARK: - Set up

    init(serviceFactory: WeatherServiceFactory) {
        let service = serviceFactory.makeWeatherService()

        weather = searchText
            .debounce(.seconds(1), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMap { searchString -> Observable<WeatherModel> in
                guard !searchString.isEmpty else { return Observable.empty() }

                return service.getWeather(city: searchString)
                    .catchAndReturn(WeatherModel.dummy())
            }
            .share()

        cityName = weather
            .map { $0.name }

        temperature = weather
            .map { String(format: "%.f", $0.main.temp) + "\u{2103}" }
        
        weatherDescription = weather
            .map { "\($0.weather[0].main)" }
        
        maxMinTemperature = weather
            .map { "Max" + " " + String(format: "%.f", $0.main.tempMax) + "\u{2103}" + " " +
                "Min" + " " + String(format: "%.f", $0.main.tempMin) + "\u{2103}"}
        
        iconWeather = weather
            .map { char in
                return service.iconNameToChar(icon: char.weather[0].icon)
            }
   }
}

protocol WeatherServiceFactory {
    func makeWeatherService() -> WeatherService
}


