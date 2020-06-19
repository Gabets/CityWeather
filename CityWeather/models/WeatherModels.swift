//
//  WeatherModels.swift
//  CityWeather
//
//  Created by Alex Gabets on 6/19/20.
//  Copyright © 2020 Gabets. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    let weather: [CityWeather]?
    let main: Temperature?    
}

struct CityWeather: Codable {
    let id: Int?
    let main: String?
    let description: String?
}

struct Temperature: Codable {
    let temp: Double?
    let feels_like: Double?
    let temp_min: Double?
    let temp_max: Double?
    let pressure: Int?
    let humidity: Int?
}
