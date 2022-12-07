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
  //  let main: String
  //  let description: String
  //  let icon: String
    let temp: Double
    let humidity: Double
    let feels_like: Double
  //  let speed: Double
  //  let gust: Double
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

enum WeatherLoadState {
    case loading
    case success
    case failed
}

class ViewModelWeather: ObservableObject {
    
    @Published private var weatherTemp: Weather?
    @Published var message: String = ""
    @Published var weatherLoadState: WeatherLoadState = .loading
    
    var temperature: Double {
        guard let temp = weatherTemp?.temp else {
            return 0.0
        }
        return temp
    }
    
    var humidity: Double {
        guard let humid  = weatherTemp?.humidity else {
            return 0.0
        }
        return humid
    }
    
    var feelsLike: Double {
        guard let feelsLike = weatherTemp?.feels_like else {
            return 0.0
        }
        return feelsLike
    }
    /*
    var main: String {
        guard let mainInfo = weatherTemp?.main else {
            return ""
        }
        return mainInfo
    }
   
    var description: String {
        guard let description = weatherTemp?.main else {
            return ""
        }
        return description
    }
  
    var icon: String {
        guard let icon = weatherTemp?.icon else {
            return ""
        }
        return icon
    }
    
   
    
    var gust: Double {
        guard let gust = weatherTemp?.gust else {
            return 0.0
        }
        return gust
    }
    
    var speed: Double {
        guard let speed = weatherTemp?.speed else {
            return 0.0
        }
        return speed
    }
    */
    func fetchWeather(city: String) {
        
        guard let city = city.escaped() else {
          //  DispatchQueue.main.async {
                self.message = "Not a city"
          //  }
            return
        }
        
        GetWeather().getWeather(city: city) { result in
            switch result {
            case .success(let temperature):
             //   DispatchQueue.main.async {
                    self.weatherTemp = temperature
              //      self.weatherLoadState = .success
             //   }
            case .failure(_ ):
                print("error")
            }
        }
    }
}

extension String {
    
    func escaped() -> String? {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
    }
}
