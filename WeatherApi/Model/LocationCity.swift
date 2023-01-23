//
//  LocationCity.swift
//  WeatherApi
//
//  Created by Emin Hayal on 9.01.2023.
//

import UIKit

struct ResponseData: Decodable {
    var cities: [LocationCityElement]
}

struct LocationCityElement: Decodable {
    let city: String? = nil
    let lat: String?
    let lng: String?
}

func loadJson(filename fileName: String) -> [LocationCityElement]? {
    if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode([LocationCityElement].self, from: data)
            return jsonData
        } catch {
            print("error:\(error)")
        }
    }
    return nil
}
