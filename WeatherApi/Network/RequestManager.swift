//
//  RequestManager.swift
//  WeatherApi
//
//  Created by Emin Hayal on 3.03.2023.
//

import Foundation

protocol WeatherManagerProtocol {
    func getWeatherItems(url: String, complete: @escaping((Weather?, String?) -> (Void)))
}

class WeatherNetworkManager: WeatherManagerProtocol {
    
    static let shared = WeatherNetworkManager()
    
    func getWeatherItems(url: String, complete: @escaping((Weather?, String?) -> (Void))) {
        
        network.request(type: Weather.self,
                        url: url,
                        method: .get) { response  in
            switch response {
            case .success(let items):
                complete(items, nil)
            case .failure(let error):
                complete(nil, error.rawValue)
            }
        }
    }
}
