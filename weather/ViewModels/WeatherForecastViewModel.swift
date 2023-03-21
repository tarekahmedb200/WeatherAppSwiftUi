//
//  WeatherForecastViewModel.swift
//  weather
//
//  Created by lapshop on 3/17/23.
//

import Foundation
import SwiftUI
import Combine

class WeatherForecastViewModel : ObservableObject , Identifiable{
    
    var id = UUID()
    
    var subscriptions = Set<AnyCancellable>()
    
    var api: API = OpenWeatherMapAPI()
    @Published var weatherForecastItem: WeatherListItem
    @Published var imageData:Data?
    
    init(weatherForecastItem: WeatherListItem) {
        self.weatherForecastItem = weatherForecastItem
        fetchWeatherIcon(self.weatherForecastItem.weather.first?.icon ?? "")
    }
    
    private let dateFormatter: ISO8601DateFormatter = {
            let formatter = ISO8601DateFormatter()
            formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
            return formatter
   }()
    
    private let timeFormatter: DateFormatter = {
          let formatter = DateFormatter()
          formatter.dateFormat = "h:mm a"
          return formatter
    }()
    
    var weatherCelsius : String {
       return "\(weatherForecastItem.main.temp)"
    }

    var dateTime : String {
        return timeFormatter.string(from: dateFormatter.date(from: weatherForecastItem.dt_txt) ?? Date())
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
    
        
}

