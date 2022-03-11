//
//  WeatherService.swift
//  Pace
//
//  Created by Tapiwa Kundishora on 2022-03-09.
//

import Foundation

import Alamofire

class WeatherService: ObservableObject {
    @Published var loading = false
    @Published var users: [User] = []
    @Published var weather: Weather?
    
    func getWeather(lat: String, long: String, completion: @escaping (Weather)->Void) {
        loading = true
        AF.request("https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(long)&appid=7e6b1a8f35b4c681f5593539c859456e&exclude=daily,minutely&units=metric",
                   method: .get
        ).responseDecodable(of: Weather.self) { (response) in
            if(response.error != nil) {
                print("AN error occores \(String(describing: response.error))")
            }
            
            if let weather = response.value {
                print("FETCHED WEATHER SUCCESFULLY")
                self.weather = response.value
                self.loading = false
                completion(weather)
            } else {
                print("FAILED TO FETCH WEATHER")
            }
            
            
           
        }
    }
}
