//
//  WeatherAPI.swift
//  Weather
//
//  Created by vinod on 12/03/23.
//

import Foundation
import Moya

struct OpenWeather {
    static let baseURL = "https://api.openweathermap.org/"
    static let apiKey = "3a5fabe12f5bccdfca69c983db89f6bb"
}

enum WeatherAPI {
    static let provider = MoyaProvider<WeatherAPI> (
        plugins: [
            NetworkLoggerPlugin (
                configuration: .init(logOptions: .verbose)
            )
        ]
    )
    
    case seachText(text: String)
    case weatherFor(lat: Double, long: Double)
}

extension WeatherAPI: TargetType {
    
    var baseURL: URL {
        URL(string: OpenWeather.baseURL)!
    }
    
    var path: String {
        switch self {
        case .seachText:
            return "geo/1.0/direct"
        case .weatherFor:
            return "data/2.5/weather"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .seachText, .weatherFor:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case let .weatherFor(lat, long):
            let payload = [
                "lat": "\(lat)",
                "lon": "\(long)",
                "units": "metric",
                "appid": OpenWeather.apiKey
            ]
            return .requestParameters(
                parameters: payload,
                encoding: URLEncoding.default
            )
        case let .seachText(locationText):
            let payload = [
                "q": locationText.replacingOccurrences(of: " ", with: ""),
                "limit": "9",
                "appid": OpenWeather.apiKey
            ]
            return .requestParameters(
                parameters: payload,
                encoding: URLEncoding.default
            )
        }
    }
    
    var headers: [String : String]? {
        ["Content-Type": "application/json"]
    }
    
    
}
