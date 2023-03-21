//
//  CityWeatherRequest.swift
//  weather
//
//  Created by lapshop on 3/17/23.
//

import Foundation

struct CityWeatherRequest: RequestProtocol {
    
    var cityName : String
    
    var path: String {
      "/data/2.5/weather"
    }
      
    var urlParams: [String: String?] {
        var urlParams = [String : String?]()
        urlParams["q"] = cityName
        urlParams["units"] = "metric"
        urlParams["appid"] = APIConstants.APIKey
        return urlParams
    }
      
    var requestType: RequestType {
      .GET
    }
    
}
