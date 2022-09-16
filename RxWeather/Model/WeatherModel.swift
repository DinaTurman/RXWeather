//
//  WeatherModel.swift
//  RxWeather
//
//  Created by Дина Турман on 06.09.2022.
//

// MARK: - Welcome
import Foundation

// MARK: - Welcome
struct WeatherModel: Codable {
    let weather: [Weather]
    let main: Main
    let name: String
    
    
    static func dummy() -> WeatherModel {
        WeatherModel(weather: [Weather(main: "Error", icon: "E")],
                     main: Main(temp: 0, tempMin: 0, tempMax: 0),
                     name: "Not Found")
    }
}


//MARK: - Main
struct Main: Codable {
    let temp: Double
    let tempMin: Double
    let tempMax: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

struct Weather: Codable {
    let main, icon: String
}
