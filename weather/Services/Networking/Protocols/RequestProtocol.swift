//
//  RequestProtocol.swift
//  WeatherApp
//
//  Created by lapshop on 3/11/23.
//

import Foundation

enum RequestType: String {
  case GET
  case POST
}

protocol RequestProtocol {
  var host: String { get }
  var path: String { get }
  var requestType: RequestType { get }
  var headers: [String: String] { get }
  var params: [String: Any] { get }
  var urlParams: [String: String?] { get }
  var addAuthorizationToken: Bool { get }
}

// MARK: - Default RequestProtocol
extension RequestProtocol {
  var host: String {
    APIConstants.host
  }

  var addAuthorizationToken: Bool {
    true
  }

  var params: [String: Any] {
    [:]
  }

  var urlParams: [String: String?] {
    [:]
  }

  var headers: [String: String] {
    [:]
  }

  func createURLRequest() throws -> URLRequest {
    var components = URLComponents()
    components.scheme = "https"
    components.host = host
    components.path = path

    if !urlParams.isEmpty {
      components.queryItems = urlParams.map { URLQueryItem(name: $0, value: $1) }
    }

    guard let url = components.url else { throw  NetworkError.badUrlRequest }

    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = requestType.rawValue

    if !headers.isEmpty {
      urlRequest.allHTTPHeaderFields = headers
    }
      
    urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

    if !params.isEmpty {
      urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params)
    }

    return urlRequest
  }
}

