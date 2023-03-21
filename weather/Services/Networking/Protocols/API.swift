//
//  API.swift
//  WeatherApp
//
//  Created by lapshop on 3/11/23.
//

import Foundation
import CoreLocation
import Combine


protocol API: AnyObject {
    func getCurrentLocationWeather(with location:CLLocation) throws  -> AnyPublisher<WeatherResponse,NetworkError>?
    func getWeatherForecast(with cityName:String) throws  -> AnyPublisher<WeatherForecastResponse,NetworkError>?
    func getCityNameLocationWeather(with cityName:String) throws  -> AnyPublisher<WeatherResponse,NetworkError>? 
    func getWeatherIcon(with iconName:String) throws  -> AnyPublisher<Data,NetworkError>?
}
