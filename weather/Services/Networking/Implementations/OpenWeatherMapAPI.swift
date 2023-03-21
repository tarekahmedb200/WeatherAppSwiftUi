//
//  OpenWeatherMapAPI.swift
//  WeatherApp
//
//  Created by lapshop on 3/11/23.
//

import Foundation
import Combine
import CoreLocation

class OpenWeatherMapAPI: API {
    
    
    let decoder = JSONDecoder()
    
    func getCurrentLocationWeather(with location:CLLocation) throws  -> AnyPublisher<WeatherResponse,NetworkError>? {
        
        let request = CurrentLocationWeatherRequest(location: location)
        guard let data = try getCurrentGenericWeatherData(with: request ,and: WeatherResponse.self) else {
            throw NetworkError.badUrlRequest
        }
        
        return data
    }
    
    
    func getWeatherForecast(with cityName:String) throws  -> AnyPublisher<WeatherForecastResponse,NetworkError>? {
        
        let request = WeatherForecastRequest(cityName: cityName)
        guard let data = try getCurrentGenericWeatherData(with: request, and: WeatherForecastResponse.self) else {
            throw NetworkError.badUrlRequest
        }
        
        return data
    }
     
    
    
    func getWeatherIcon(with iconName:String) throws  -> AnyPublisher<Data,NetworkError>? {
        
        guard let request = try? WeatherImageIconRequest(iconName: iconName).createURLRequest() else {
            throw NetworkError.badUrlRequest
        }
        
        return URLSession
            .shared
            .dataTaskPublisher(for: request)
            .tryMap { data , response in
                
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains( httpResponse.statusCode) else {
                    throw NetworkError.badUrlRequest
                }
                
                return data
            }
            .mapError { error -> NetworkError in
                switch error {
                case is URLError :
                    return .badUrlRequest
                default : return .badUrlRequest
                }
            }
            .eraseToAnyPublisher()
    }
    
    
    
    func getCityNameLocationWeather(with cityName:String) throws  -> AnyPublisher<WeatherResponse,NetworkError>? {
        
        let request = CityWeatherRequest(cityName:cityName)
        guard let data = try getCurrentGenericWeatherData(with: request ,and: WeatherResponse.self) else {
            throw NetworkError.badUrlRequest
        }
        
        return data
    }
    
    
    
    
    
    func getCurrentGenericWeatherData<T:Decodable>(with request:RequestProtocol , and type: T.Type) throws  -> AnyPublisher<T,NetworkError>? {
        
        
        guard let request = try? request.createURLRequest() else {
            throw NetworkError.badUrlRequest
        }
        
        return URLSession
            .shared
            .dataTaskPublisher(for: request)
            .tryMap { data , response in
                
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains( httpResponse.statusCode) else {
                    throw NetworkError.badUrlRequest
                }
                
                return data
            }
            .decode(type: T.self, decoder: decoder)
            .mapError { error -> NetworkError in
                switch error {
                case is URLError :
                    print(error.localizedDescription)
                    return .badUrlRequest
                default :
                    print(error.localizedDescription)
                    return .badUrlRequest
                    
                }
            }
            .eraseToAnyPublisher()
    }
    
    
    
    
    
    
    
    
    
    
    
}
