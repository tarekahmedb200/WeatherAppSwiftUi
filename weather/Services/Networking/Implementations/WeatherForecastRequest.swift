//
//  WeatherForecastRequest.swift
//  weather
//
//  Created by lapshop on 3/17/23.
//

import Foundation

struct WeatherForecastRequest: RequestProtocol {
    
    var cityName: String
    
    var urlParams: [String: String?] {
        var urlParams = [String : String?]()
        urlParams["q"] = cityName
        urlParams["appid"] = APIConstants.APIKey
        urlParams["units"] = "metric"
        return urlParams
    }
    
    var path: String {
        "/data/2.5/forecast"
    }
          
    var requestType: RequestType {
      .GET
    }
    
}

