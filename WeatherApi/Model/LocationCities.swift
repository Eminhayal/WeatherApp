//
//  LocationCities.swift
//  WeatherApi
//
//  Created by Emin Hayal on 9.01.2023.
//

import Foundation

struct LocationCities: Codable {
    let name: String
    let lastName: String
    let age: Int
}

func loadJson(fileName: String) -> Person? {
   let decoder = JSONDecoder()
   guard
        let url = Bundle.main.url(forResource: fileName, withExtension: "json"),
        let data = try? Data(contentsOf: url),
        let person = try? decoder.decode(Person.self, from: data)
   else {
        return nil
   }

   return person
}
