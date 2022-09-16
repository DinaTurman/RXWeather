//
//  WeatherRequest.swift
//  RxWeather
//
//  Created by Дина Турман on 06.09.2022.
//


struct WeatherRequest: Request {
    typealias ResponseType = WeatherModel
    
    let city: String
    
    let apiKey = "2b283cff62482aa9cd381ccae5bf5eb7"
    var baseUrl = "https://api.openweathermap.org"
    
    var path: String {
           return "/data/2.5/weather"
    }
    
    var query: Parameters? {
        ["q": city,
         "appid": "2b283cff62482aa9cd381ccae5bf5eb7",
         "units": "metric"]
    }
}
