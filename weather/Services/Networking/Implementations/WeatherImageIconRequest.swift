//
//  WeatherImageIconRequest.swift
//  weather
//
//  Created by lapshop on 3/11/23.
//

import Foundation


struct WeatherImageIconRequest: RequestProtocol {
    
    var iconName: String
    
    var host: String {
        return "openweathermap.org"
    }
    
    var path: String {
      "/img/wn/\(iconName)@2x.png"
    }
          
    var requestType: RequestType {
      .GET
    }
    
}
