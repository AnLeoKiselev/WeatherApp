//
//  WeatherData.swift
//  Weather
//
//  Created by Anatoliy on 13.01.2023.
//


//https://api.openweathermap.org/data/2.5/weather?appid=1280a0c14d1305d05568558ca9c86eea&units=metric&q=Moscow

import Foundation

struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let description: String
    let icon: String
}

