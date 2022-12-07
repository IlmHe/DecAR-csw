//
//  Weather.swift
//  DecAR
//
//  Created by iosdev on 6.12.2022.
//

import Foundation
import SwiftUI

let weatherSearch = NSLocalizedString("weatherSearch", comment: "weatherSearch")
let weatherFetchJoke = NSLocalizedString("weatherFetchJoke", comment: "weatherFetchJoke")


enum NetwokrError: Error {
    case decodingError
    case badUrl
    case somethingWentWrong
}

class GetWeather {
    
    @State private var apiKey = ""
    @State private var language: String = "en"
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
    
    func getWeather(city: String, completion: @escaping (Result<Weather?, NetwokrError>) -> Void) {
        
        guard let url = urlWeather(city) else {
           return completion(.failure(.badUrl))
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                return completion(.failure(.somethingWentWrong))
            }
            
            let weatherResponse = try? JSONDecoder().decode(WeatherCall.self, from: data)
            if let weatherResponse = weatherResponse {
                completion(.success(weatherResponse.main))
            } else {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
/*
extension URL {
    
    
}*/

struct WeatherView: View {
    @ObservedObject private var weatherInfo = ViewModelWeather()
    @State private var joke: String = ""
    @State private var city: String = ""
    
       var body: some View {
           
           VStack {
               
               TextField(weatherSearch, text: self.$city,
               onEditingChanged: { _ in }, onCommit: {
                   
                   self.weatherInfo.fetchWeather(city: self.city)
               }).textFieldStyle(RoundedBorderTextFieldStyle())
           }
           //Group {
               Text("Temperature: \(self.weatherInfo.temperature, specifier: "%.1f") ℃")
               Text("Feels like: \(self.weatherInfo.feelsLike , specifier: "%.1f") ℃")
               Text("Humidity: \(self.weatherInfo.humidity, specifier: "%.1f") %")
             //  Text("Wind speed: \(self.weatherInfo.speed , specifier: "%.1f") m/s")
             //  Text("Gust speed: \(self.weatherInfo.gust , specifier: "%.1f") m/s")
             //  Text("Icon \(self.weatherInfo.icon)")
             //  Text("Description: \(self.weatherInfo.description)")
              // Text("Main \(self.weatherInfo.main)")
          // }
           

           Text(self.weatherInfo.message)
              // .onAppear() {
              //     self.weatherInfo.fetchWeather(city: self.city)
              // }
           /*
            let main: String
            let description: String
            let icon: String
        
            let feels_like: Double
            let speed: Double
            let gust: Double
            */
           
           Text(joke)
           Button {
               Task {
                   let (data, _) = try await URLSession.shared.data(from: URL(string:"https://api.chucknorris.io/jokes/random")!)
                   let decodedResponse = try? JSONDecoder().decode(Joke.self, from: data)
                   joke = decodedResponse?.value ?? ""
               }
           } label: {
               Text(weatherFetchJoke)
        }
    }
}
  
struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}

struct Joke: Codable {
    let value: String
}
