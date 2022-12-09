//
//  WeatherCall.swift
//  DecAR
//
//  Created by iosdev on 6.12.2022.
//

import Foundation

struct WeatherCall: Decodable {
    let main: Weather
}
 struct WeatherCallWind: Decodable {
     let wind: Wind
 }

 struct Weather: Decodable {
     let temp: Double
     let humidity: Double
     let feels_like: Double
 }
 
struct WeatherCallDescription: Decodable {
        let weather: [MainInfo]
}

struct MainInfo: Decodable {
    let main: String
    let description: String
    let icon: String
    var weatherIconUrl: URL {
        let iconUrl = "http://openweathermap.org/img/wn/\(icon)@2x.png"
        return URL(string: iconUrl)!
    }
}

 struct Wind: Decodable {
     let speed: Double
 }

enum WeatherLoadState {
    case loading
    case success
    case failed
}

class ViewModelWeather: ObservableObject {
    @Published private var weatherAllInfo: MainInfo?
    @Published private var weatherTemp: Weather?
    @Published private var weatherWind: Wind?
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

    var main: String {
        guard let mainInfo = weatherAllInfo?.main else {
            return ""
        }
        return mainInfo
    }

    var description: String {
        guard let description = weatherAllInfo?.description else {
            return ""
        }
        return description
    }

    var weatherIconurl: URL {
        guard let weatherIconUrl = weatherAllInfo?.weatherIconUrl else {
            return URL(string: "https://openweathermap.org/img/wn/10d@2x.png")!
        }
        return weatherIconUrl
    }
    
    var icon: String {
        guard let icon = weatherAllInfo?.icon else {
            return ""
        }
        return icon
    }
 

    var speed: Double {
        guard let speed = weatherWind?.speed else {
            return 0.0
        }
        return speed
    }
   
    func fetchWeather(city: String) {
        
        guard let city = city.escaped() else {
            DispatchQueue.main.async {
                self.message = "Not a city"
            }
            
            return
        }
        
        GetWeather().getWeatherDescription(city: city) { result in
            switch result {
            case .success(let description):
                DispatchQueue.main.async {
                    self.weatherAllInfo = description
                    self.weatherLoadState = .success
                }
            case .failure(_ ):
                print("error")
            }
        }
        
        GetWeather().getWeather(city: city) { result in
            switch result {
            case .success(let temperature):
                DispatchQueue.main.async {
                    self.weatherTemp = temperature
                    self.weatherLoadState = .success
                }
            case .failure(_ ):
                print("error")
            }
        }
        
        GetWeather().getWeatherWind(city: city) { result in
            switch result {
            case .success(let wind):
                DispatchQueue.main.async {
                    self.weatherWind = wind
                    self.weatherLoadState = .success
                }
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


/*
 struct WeatherDescription: Decodable {
     let weatherArray: [WeatherDescInfo]
 }

 struct WeatherDescInfo: Decodable {
     let main: String
     let description: String
     let icon: String
 }
 
struct WeatherCallDescription: Decodable {
    struct WeatherAllInfo: Decodable {
        let speed: Double
        let temp: Double
        let humidity: Double
        let feels_like: Double
        struct MainInfo: Decodable {
            let main: String
            let description: String
            let icon: String
            var weatherIconUrl: URL {
                let iconUrl = "http://openweathermap.org/img/wn/\(icon)@2x.png"
                return URL(string: iconUrl)!
            }
        }
        let mainInfo: [MainInfo]
    }
    let weatherDescInfo: [WeatherAllInfo]
    //let weather: WeatherDescription
}
 
 let weatherService = WeatherService.shared

 var apiKey = "10fa652305f6b2fc849c3ac9acdc7e50"
 var language: String = "en"
 // @State private var city = "Espoo"

 func urlWeather(_ city: String) -> URL? {
     guard let url = URL(string:
                             "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric&lang=\(language)"
                             //"https://api.openweathermap.org/data/2.5/weather?q=houston&appid=\(apiKey)"
     ) else {
         return nil
     }
     return url
 }
 // @Published private var weatherDescription: WeatherDescInfo?
//  @Published private var weatherDescription: [WeatherCallDescription.WeatherDescription?]
*/

/*
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

var main: String {
    guard let mainInfo = weatherDescription?.main else {
        return ""
    }
    return mainInfo
}

var description: String {
    guard let description = weatherDescription?.description else {
        return ""
    }
    return description
}

var icon: String {
    guard let icon = weatherDescription?.icon else {
        return ""
    }
    return icon
}
 

var gust: Double {
    guard let gust = weatherWind?.gust else {
        return 0.0
    }
    return gust
}

var speed: Double {
    guard let speed = weatherWind?.speed else {
        return 0.0
    }
    return speed
}
*/
