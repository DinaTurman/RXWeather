//
//  BaseService.swift
//  RxWeather
//
//  Created by Дина Турман on 14.09.2022.
//
import Foundation

class BaseService<T> {
    let client: T

    init(client: T) {
        self.client = client
    }
}



