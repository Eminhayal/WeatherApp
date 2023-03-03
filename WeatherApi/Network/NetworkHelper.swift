//
//  NetworkHelper.swift
//  WeatherApi
//
//  Created by Emin Hayal on 3.03.2023.
//

import Foundation

import Foundation

enum HTTPMethods: String {
    case get = "GET"
    case post = "POST"
}

enum ErrorTypes: String, Error {
    case badURL
    case requestFailed
    case unknownError
    case invalidData
}

class NetworkHelper {
    static let shared = NetworkHelper()
    
    let baseURL = ""
    
    let header = ["Auth", "Bearer "]
}
