//
//  WeatherCall.swift
//  DecAR
//
//  Created by iosdev on 6.12.2022.
//

import Foundation

struct WeatherCall: Decodable {
   // let weather: Temperature
    let main: Weather
   // let wind: Wind
}

struct Weather: Decodable {
   // let main: String
   // let description: String
   // let icon: String
    let temp: Double
    let humidity: Double
   // let feels_like: Double
   // let speed: Double
   // let gust: Double
}

struct Temperature: Decodable {
    let temp: Double
    let humidity: Double
    let feels_like: Double
}

struct Wind: Decodable {
    let speed: Double
    let gust: Double
}

class ViewModelWeather: ObservableObject {
    
   @Published private var weatherTemp: Weather?
    
    var temperature: Double {
        guard let temp = weatherTemp?.temp else {
            return 0.0
        }
        return temp
    }
    
    func fetchWeather(city: String) {
        GetWeather().getWeather(city: city) { result in
            switch result {
            case .success(let temperature):
                self.weatherTemp = temperature
            case .failure(_ ):
                print("error")
            }
        }
    }
}
