//
//  WeatherModel.swift
//  Weather
//
//  Created by Anatoliy on 13.01.2023.
//

import Foundation

struct WeatherModel {
    
    let iconId: String
    let cityName: String
    let temperature: Double
    let description: String
    let feelsLike: Double
    
    //This is a computed property:
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    var feelsLikeString: String {
        return String(format: "%.1f", feelsLike)
    }
    
    var conditionName: String {
        switch iconId {
            
        case ("01d"): return "clear_sky_day"
        case ("01n"): return "clear_sky_night"
            
        case ("02d"): return "few_clouds_day"
        case ("02n"): return "few_clouds_night"
            
        case ("03d"): return "scattered_clouds_day"
        case ("03n"): return "scattered_clouds_night"
            
        case ("04d"): return "broken_clouds_day"
        case ("04n"): return "broken_clouds_night"
            
        case ("09d"): return "shower_rain_day"
        case ("09n"): return "shower_rain_night"
            
        case ("10d"): return "rain_day"
        case ("10n"): return "rain_night"
            
        case ("11d"): return "thunderstorm_day"
        case ("11n"): return "thunderstorm_night"
            
        case ("13d"): return "snow_day"
        case ("13n"): return "snow_night"
            
        case ("50d"): return "mist_day"
        case ("50n"): return "mist_night"
            
        default :
            return "error"
        }
    }
}

