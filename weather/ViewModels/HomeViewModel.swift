//
//  HomeViewModel.swift
//  WeatherApp
//
//  Created by lapshop on 3/11/23.
//

import Foundation
import SwiftUI
import Combine
import CoreLocation

@MainActor
class HomeViewModel : ObservableObject {
    @Published var weatherData: WeatherResponse?
    @Published var weatherForecastResponse : WeatherForecastResponse?
    var locationMananger = LocationManager()
    var api: API = OpenWeatherMapAPI()
    var subscriptions = Set<AnyCancellable>()
    @Published var imageData: Data?
    @Published var cityName = "Egypt"
    @Published var weatherForecastViewModelList: [WeatherForecastViewModel] = []
    
    var weatherMainTitle : String {
       return weatherData?.weather.first?.main ?? ""
    }
    
    var weatherCelsius : String {
       return "\(weatherData?.main.temp ?? 0)°"
    }
    
    var weatherMinCelsius : String {
       return "\(weatherData?.main.tempMin ?? 0)"
    }
    
    var weatherMaxCelsius : String {
       return "\(weatherData?.main.tempMax ?? 0)"
    }
    

    init() {
        locationMananger
            .observable
            .sink { [weak self] location in
                guard let weakSelf = self else {
                    return
                }
               weakSelf.fetchCurrentWeatherLocation(location)
                weakSelf.fetchWeatherForecast()
            }
            .store(in: &subscriptions)
    }
    
    func fetchCurrentWeatherLocation(_ location: CLLocation)  {
        do {
            try api.getCurrentLocationWeather(with: location)?
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: {
                print($0)
            }, receiveValue: { [weak self] weatherData in
                guard let weakSelf = self else {
                    return
                }
                weakSelf.weatherData = weatherData
                weakSelf.fetchWeatherIcon(weatherData.weather.first?.icon ?? "")
            })
            .store(in: &subscriptions)
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchCurrentWeatherLocation()  {
        do {
            try api.getCityNameLocationWeather(with: cityName)?
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: {
                print($0)
            }, receiveValue: { [weak self] weatherData in
                guard let weakSelf = self else {
                    return
                }
                weakSelf.weatherData = weatherData
                weakSelf.fetchWeatherIcon(weatherData.weather.first?.icon ?? "")
            })
            .store(in: &subscriptions)
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    
    
    
    func fetchWeatherIcon(_ iconName: String)  {
        do {
            try api.getWeatherIcon(with: iconName)?
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: {
                print($0)
            }, receiveValue: { [weak self] imageData in
                guard let weakSelf = self else {
                    return
                }
                weakSelf.imageData = imageData
            })
            .store(in: &subscriptions)
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    
    func fetchWeatherForecast()  {
        do {

            try api.getWeatherForecast(with: cityName)?
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: {
                print($0)
            }, receiveValue: { [weak self] weatherForecastResponse in
                guard let weakSelf = self else {
                    return
                }
                
                weakSelf.weatherForecastResponse = weatherForecastResponse
                weakSelf.weatherForecastViewModelList.removeAll()
                weatherForecastResponse.list.forEach({
                    let viewModel = WeatherForecastViewModel(weatherForecastItem: $0)
                    weakSelf.weatherForecastViewModelList.append(viewModel)
                })
                
            })
            .store(in: &subscriptions)
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    
    
    
}



