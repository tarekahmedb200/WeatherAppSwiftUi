//
//  Forecast.swift
//  weather
//
//  Created by lapshop on 3/17/23.
//

import Foundation


struct WeatherForecastResponse: Codable {
    let cod: String
    let message: Int
    let cnt: Int
    let list: [WeatherListItem]
    let city: WeatherCity
}

struct WeatherListItem: Codable {
    let dt: Int
    let main: WeatherMain
    let weather: [WeatherDescription]
    let clouds: WeatherClouds
    let wind: WeatherWind
    let visibility: Int
    let pop: Double
    let sys: WeatherSys
    let dt_txt: String
}

struct WeatherMain: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let sea_level: Int
    let grnd_level: Int
    let humidity: Int
    let temp_kf: Double
}

struct WeatherDescription: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct WeatherClouds: Codable {
    let all: Int
}

struct WeatherWind: Codable {
    let speed: Double
    let deg: Int
    let gust: Double?
}

struct WeatherSys: Codable {
    let pod: String
}

struct WeatherCity: Codable {
    let id: Int
    let name: String
    let coord: WeatherCoordinates
    let country: String
    let population: Int
    let timezone: Int
    let sunrise: Int
    let sunset: Int
}

struct WeatherCoordinates: Codable {
    let lat: Double
    let lon: Double
}



