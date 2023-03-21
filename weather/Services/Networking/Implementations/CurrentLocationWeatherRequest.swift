//
//  CurrentLocationWeatherRequest.swift
//  WeatherApp
//
//  Created by lapshop on 3/11/23.
//

import Foundation
import CoreLocation

struct CurrentLocationWeatherRequest: RequestProtocol {
    
    var location: CLLocation
    
    var path: String {
      "/data/2.5/weather"
    }
      
    var urlParams: [String: String?] {
        var urlParams = [String : String?]()
        urlParams["lat"] = location.coordinate.latitude.description
        urlParams["lon"] = location.coordinate.longitude.description
        urlParams["units"] = "metric"
        urlParams["appid"] = APIConstants.APIKey
        return urlParams
    }
      
    var requestType: RequestType {
      .GET
    }
    
}




