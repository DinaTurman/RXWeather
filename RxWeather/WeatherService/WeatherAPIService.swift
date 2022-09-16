//
//  WeatherAPIService.swift
//  RxWeather
//
//  Created by Дина Турман on 06.09.2022.
//

import RxSwift

final class WeatherService: BaseService<Network> {
    
    //imperative
    func getWeather(city: String, completion: @escaping (NetworkResult<WeatherRequest.ResponseType>) -> Void) {
        let request = WeatherRequest(city: city)
        client.execute(request: request, completion: completion)
    }
    
    //reactive
    func getWeather(city: String) -> Observable<WeatherRequest.ResponseType> {
        let request = WeatherRequest(city: city)

        return client.execute(with: request)
    }
    
    func iconNameToChar(icon: String) -> String {
        switch icon {
        case "01d":
            return "\u{2600}"
        case "01n":
            return "\u{1F319}"
        case "02d":
            return "\u{1F325}"
        case "02n":
            return "\u{2601}"
        case "03d", "03n":
            return "\u{2601}"
        case "04d", "04n":
            return "\u{1F329}"
        case "09d", "09n":
            return "\u{1F328}"
        case "10d", "10n":
            return "\u{1F328}"
        case "11d", "11n":
            return "\u{26C8}"
        case "13d", "13n":
            return "\u{1F328}"
        case "50d", "50n":
            return "\u{1F32B}"
        default:
            return "E"
        }
    }
}
