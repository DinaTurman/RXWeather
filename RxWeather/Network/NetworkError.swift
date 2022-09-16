//
//  NetworkError.swift
//  RxWeather
//
//  Created by Дина Турман on 06.09.2022.
//

public enum NetworkError: String, Error {
    case missingURL
    case missingRequest
    case taskError
    case responseError
    case dataError
    case decodeError
}

