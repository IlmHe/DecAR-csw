//
//  Weather.swift
//  DecAR
//
//  Created by iosdev on 6.12.2022.
//

import Foundation
import SwiftUI

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
               
               TextField("Search", text: self.$city,
               onEditingChanged: { _ in }, onCommit: {
                   
                   self.weatherInfo.fetchWeather(city: self.city)
               }).textFieldStyle(RoundedBorderTextFieldStyle())
           }
           Text("\(self.weatherInfo.temperature) ℃")
              // .onAppear() {
              //     self.weatherInfo.fetchWeather(city: self.city)
              // }
           
           Text(joke)
           Button {
               Task {
                   let (data, _) = try await URLSession.shared.data(from: URL(string:"https://api.chucknorris.io/jokes/random")!)
                   let decodedResponse = try? JSONDecoder().decode(Joke.self, from: data)
                   joke = decodedResponse?.value ?? ""
               }
           } label: {
               Text("Fetch Joke")
        }
    }
}
  
struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}

struct CuurentWeather: Codable {
    
}

struct Joke: Codable {
    let value: String
}
