//
//  Network.swift
//  WeatherApi
//
//  Created by Emin Hayal on 2.01.2023.
//

import Foundation

protocol Network {
    func getWeatherData(url: String, completion: @escaping (Weather? , String?) -> Void)
}

extension Api: Network {
    func getWeatherData(url: String, completion: @escaping (Weather? , String?) -> Void) {
        network.getData(url: url) { [weak self] (response: Weather?, error: String?)   in
            completion(response, error)
        }
    }
}
