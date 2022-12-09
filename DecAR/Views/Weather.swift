//
//  Weather.swift
//  DecAR
//
//  Created by iosdev on 6.12.2022.
//

import Foundation
import CoreLocation
import SwiftUI
import Combine

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
    
    func urlWeather(_ city: String) -> URL? {
        guard let url = URL(string:
                                "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric&lang=\(language)"
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
    
    func getWeatherDescription(city: String, completion: @escaping (Result<MainInfo?, NetwokrError>) -> Void) {
     
     guard let url = urlWeather(city) else {
     return completion(.failure(.badUrl))
     }
     
     URLSession.shared.dataTask(with: url) { data, response, error in
     
     guard let data = data, error == nil else {
     return completion(.failure(.somethingWentWrong))
     }
     
         let weatherResponse = try? JSONDecoder().decode(WeatherCallDescription.self, from: data)
     if let weatherResponse = weatherResponse {
         completion(.success(weatherResponse.weather[0]))
         print("main info \(weatherResponse.weather)")
     } else {
     completion(.failure(.decodingError))
     }
     }.resume()
     }
     
    func getWeatherWind(city: String, completion: @escaping (Result<Wind?, NetwokrError>) -> Void) {
        
        guard let url = urlWeather(city) else {
            return completion(.failure(.badUrl))
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                return completion(.failure(.somethingWentWrong))
            }
            
            let weatherResponse = try? JSONDecoder().decode(WeatherCallWind.self, from: data)
            if let weatherResponse = weatherResponse {
                completion(.success(weatherResponse.wind))
                print("main info \(weatherResponse.wind)")

            } else {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}

struct WeatherView: View {
    
    @ObservedObject private var weatherInfo = ViewModelWeather()
    @State private var joke: String = ""
    @State private var city: String = ""
    var url = URL(string: "https://openweathermap.org/img/wn/10d@2x.png")

       var body: some View {
           
           VStack {
               Text("Current weather")
                   .font(.title)
                   .padding(.horizontal)
               HStack {
                   TextField(weatherSearch, text: self.$city,
                             onEditingChanged: { _ in }, onCommit: {
                       
                       self.weatherInfo.fetchWeather(city: self.city)
                   }).textFieldStyle(RoundedBorderTextFieldStyle())
                       .padding(5)
                   Button {
                       self.weatherInfo.fetchWeather(city: self.city)
                   } label: {
                       Image(systemName: "magnifyingglass.circle.fill")
                           .font(.title3)
                           .padding(5)
                   }
               }
               Spacer()
               HStack{
                   AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(self.weatherInfo.icon)@2x.png")) { phase in
                       switch phase {
                       case .empty:
                           ProgressView()
                               .progressViewStyle(.circular)
                       case .success(let image):
                           image.resizable()
                               .aspectRatio(contentMode: .fit)
                       default: Color.clear // <-- here
                       }
                   }
                   .frame(maxWidth: 150, maxHeight: 150)
                   .padding()
                       .overlay(
                           RoundedRectangle(cornerRadius: 16)
                               .stroke(.blue, lineWidth: 4)
                       )
                       Group {
                           VStack {
                           Text("\(self.weatherInfo.temperature, specifier: "%.1f") ℃")
                                   .font(.largeTitle)
                           Text("Temperature")
                       }
                       }
                       .padding()
                           .overlay(
                               RoundedRectangle(cornerRadius: 16)
                                   .stroke(.blue, lineWidth: 4)
                           )
                    
               }
               Spacer()
               Group {
                   VStack {
                       Text("Feels like: \(self.weatherInfo.feelsLike , specifier: "%.1f") ℃")
                           .font(.title2)
                           .padding()
                               .overlay(
                                   RoundedRectangle(cornerRadius: 16)
                                       .stroke(.blue, lineWidth: 2)
                               )
                       Text("Humidity: \(self.weatherInfo.humidity, specifier: "%.1f") %")
                           .font(.title2)
                           .padding()
                               .overlay(
                                   RoundedRectangle(cornerRadius: 16)
                                       .stroke(.blue, lineWidth: 2)
                               )
                       Text("Wind speed: \(self.weatherInfo.speed , specifier: "%.1f") m/s")
                           .font(.title2)
                           .padding()
                               .overlay(
                                   RoundedRectangle(cornerRadius: 16)
                                       .stroke(.blue, lineWidth: 2)
                               )
                       //  Text("Icon \(self.weatherInfo.icon)")
                       Text("Description: \(self.weatherInfo.description)")
                           .font(.title2)
                           .padding()
                               .overlay(
                                   RoundedRectangle(cornerRadius: 16)
                                       .stroke(.blue, lineWidth: 2)
                               )
                       Text("Main \(self.weatherInfo.main)")
                           .font(.title2)
                           .padding()
                               .overlay(
                                   RoundedRectangle(cornerRadius: 16)
                                       .stroke(.blue, lineWidth: 4)
                               )
                       Text(self.weatherInfo.message)
                       //  Text("https://openweathermap.org/img/wn/\(self.weatherInfo.icon)@2x.png")
                   }
               }
               
           }
            Spacer()
           Text(joke)
               .padding(2)
               .font(.title3)
           Button {
               Task {
                   let (data, _) = try await URLSession.shared.data(from: URL(string:"https://api.chucknorris.io/jokes/random")!)
                   let decodedResponse = try? JSONDecoder().decode(Joke.self, from: data)
                   joke = decodedResponse?.value ?? ""
               }
           } label: {
               Text(weatherFetchJoke)
        }
           Spacer()
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


/*
 extension UIImageView {
     func loadFrom(URLAddress: String) {
         guard let url = URL(string: URLAddress) else {
             return
         }
         
         DispatchQueue.main.async { [weak self] in
             if let imageData = try? Data(contentsOf: url) {
                 if let loadedImage = UIImage(data: imageData) {
                         self?.image = loadedImage
                 }
             }
         }
     }
 }

 
 extension UIImageView {
     func loadFrom(URLAddress: String) {
         guard let url = URL(string: URLAddress) else {
             return
         }
         
         DispatchQueue.main.async { [weak self] in
             if let imageData = try? Data(contentsOf: url) {
                 if let loadedImage = UIImage(data: imageData) {
                         self?.image = loadedImage
                 }
             }
         }
     }
 }


 class ImageLoader: ObservableObject {
     @Published var image: UIImage?
     private let url: URL
     private var cancellable: AnyCancellable?
     
     
     init(url: URL) {
         self.url = url
     }

     deinit {
         cancel()
     }
     
     func load() {
         cancellable = URLSession.shared.dataTaskPublisher(for: url)
                     .map { UIImage(data: $0.data) }
                     .replaceError(with: nil)
                     .receive(on: DispatchQueue.main)
                     .sink { [weak self] in self?.image = $0 }
     }

     func cancel() {
         cancellable?.cancel()
     }
 }

 struct AsyncImage<Placeholder: View>: View {
     @StateObject private var loader: ImageLoader
     private let placeholder: Placeholder

     init(url: URL, @ViewBuilder placeholder: () -> Placeholder) {
         self.placeholder = placeholder()
         _loader = StateObject(wrappedValue: ImageLoader(url: url))
     }

     var body: some View {
         content
             .onAppear(perform: loader.load)
     }

     private var content: some View {
         Group {
                     if loader.image != nil {
                         Image(uiImage: loader.image!)
                             .resizable()
                     } else {
                         placeholder
                     }
                 }
     }
 }
 
 
class WeatherService {
    static let shared = WeatherService()
    
    func getJSON(urlString: String, completion: @escaping (Result<WeatherCallDescription, NetwokrError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.badUrl("Error: Bad URL")))
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { (data, response, error ) in
            if let error = error {
                completion(.failure(.somethingWentWrong))
                return
            }
            guard let data = data else {
                completion(.failure(.somethingWentWrong))
                return
            }
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(WeatherCallDescription.self, from: data)
                completion(.success(decodedData))
            } catch let decodeError {
                completion(.failure(NetwokrError.decodingError))
                return
            }
        }.resume()
    }
} 

 class ImageLoader: ObservableObject {
     @Published var image: UIImage?
     private let url: URL
     private var cancellable: AnyCancellable?
     
     
     init(url: URL) {
         self.url = url
     }

     deinit {
         cancel()
     }
     
     func load() {
         cancellable = URLSession.shared.dataTaskPublisher(for: url)
                     .map { UIImage(data: $0.data) }
                     .replaceError(with: nil)
                     .receive(on: DispatchQueue.main)
                     .sink { [weak self] in self?.image = $0 }
     }

     func cancel() {
         cancellable?.cancel()
     }
 }

 struct AsyncImage<Placeholder: View>: View {
     @StateObject private var loader: ImageLoader
     private let placeholder: Placeholder

     init(url: URL, @ViewBuilder placeholder: () -> Placeholder) {
         self.placeholder = placeholder()
         _loader = StateObject(wrappedValue: ImageLoader(url: url))
     }

     var body: some View {
         content
             .onAppear(perform: loader.load)
     }

     private var content: some View {
         Group {
                     if loader.image != nil {
                         Image(uiImage: loader.image!)
                             .resizable()
                     } else {
                         placeholder
                     }
                 }
     }
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

func getWeatherDescription(city: String, completion: @escaping (Result<[WeatherCallDescription.WeatherDescription?], NetwokrError>) -> Void) {
    
    guard let url = urlWeather(city) else {
       return completion(.failure(.badUrl))
    }
    
    URLSession.shared.dataTask(with: url) { data, response, error in
        
        guard let data = data, error == nil else {
            return completion(.failure(.somethingWentWrong))
        }
        
        let weatherResponse = try? JSONDecoder().decode(WeatherCallDescription.self, from: data)
        if let weatherResponse = weatherResponse {
            completion(.success(weatherResponse.weatherDescInfo))
        } else {
            completion(.failure(.decodingError))
        }
    }.resume()
}

func getWeatherWind(city: String, completion: @escaping (Result<Wind?, NetwokrError>) -> Void) {
    
    guard let url = urlWeather(city) else {
       return completion(.failure(.badUrl))
    }
    
    URLSession.shared.dataTask(with: url) { data, response, error in
        
        guard let data = data, error == nil else {
            return completion(.failure(.somethingWentWrong))
        }
        
        let weatherResponse = try? JSONDecoder().decode(WeatherCallWind.self, from: data)
        if let weatherResponse = weatherResponse {
            completion(.success(weatherResponse.wind))
        } else {
            completion(.failure(.decodingError))
        }
    }.resume()
} */


//FUUUUUUUUUUUUUUUUUU
/*
 //let weatherService = WeatherService.shared
 @State private var apiKey = "10fa652305f6b2fc849c3ac9acdc7e50"
 @State private var language: String = "en"
// @State private var city = "Espoo"
 CLGeocoder().geocodeAddressString("Vantaa") { (placemarks, error) in
     if let error = error {
         print("Geolocation error")
     }
     if let latitude = placemarks?.first.location?.coordinate.latitude
         let longitude = placemarks?.first?.location.coordinate.longitude {
         weatherService.getJSON(urlString: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)") {
             (result: Result<WeatherCallDescription, NetwokrError>) in
             switch result {
             case .success(let weatherCall):
                 once in weatherCall.weatherDescInfo {
                     print("Description: ", once.mainInfo[0].description
                 }
             }
         }
     }
 }
 
 func urlWeather(_ city: String) -> URL? {
     guard let url = URL(string:
                             "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric&lang=\(language)"
                             //"https://api.openweathermap.org/data/2.5/weather?q=houston&appid=\(apiKey)"
     ) else {
         return nil
     }
     return url
 }
 
 func getWeather(city: String) { result: Result<WeatherCallDescription, NetwokrError>) in
     switch result {
         
     guard let url = urlWeather(city) else {
        return completion(.failure(.badUrl("Error: Bad URL")))
     }
     URLSession.shared.dataTask(with: url) { data, response, error in
         
         guard let data = data, error == nil else {
             return completion(.failure(.somethingWentWrong))
         }
         
 }
 
 
 
}
 */
