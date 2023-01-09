//
//  Weather.swift
//  WeatherApi
//
//  Created by Emin Hayal on 5.01.2023.
//
import Foundation

// MARK: - Weather
struct Weather: Codable {
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    let timelines: [Timeline]?
}

// MARK: - Timeline
struct Timeline: Codable {
    let timestep: String?
    let endTime: String?
    let startTime: String?
    let intervals: [Interval]?
}

// MARK: - Interval
struct Interval: Codable {
    let startTime: String?
    let values: Values?
}

// MARK: - Values
struct Values: Codable {
    let temperature: Double?
}

