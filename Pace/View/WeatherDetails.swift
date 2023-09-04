//
//  WeatherDetails.swift
//  Pace
//
//  Created by Tapiwa Kundishora on 2022-03-15.
//

import SwiftUI

struct WeatherDetailsScreen: View {
    var weather: WeatherDetails
    var body: some View {
            List {
                Section(header: Text("Conditions")) {
                    HStack {
                        Text("Temperature")
                        Spacer()
                        Text(String("\(Int(weather.temp))°"))
                            .foregroundColor(.secondary)
                    }
                    HStack {
                        Text("Feels like")
                        Spacer()
                        Text(String("\(Int(weather.feelsLike))°"))
                            .foregroundColor(.secondary)
                    }
                    HStack {
                        Text("Humidity")
                        Spacer()
                        Text(String("\(weather.humidity)%"))
                            .foregroundColor(.secondary)
                    }
                    HStack {
                        Text("Pressure")
                        Spacer()
                        Text(String("\(weather.pressure)hPa"))
                            .foregroundColor(.secondary)
                    }
                    HStack {
                        Text("Desc")
                        Spacer()
                        Text(String("\(weather.weatherElement.weatherDescription)"))
                            .foregroundColor(.secondary)
                    }
                }
                
                Section(header: Text("Wind")) {
                    HStack {
                        Text("Wind Speed")
                        Spacer()
                        Text(String("\(Int(weather.windSpeed))m/s"))
                            .foregroundColor(.secondary)
                    }
                    HStack {
                        Text("Feels gust")
                        Spacer()
                        Text(String("\(Int(weather.windGust))m/s"))
                            .foregroundColor(.secondary)
                    }
                    HStack {
                        Text("Wind direction")
                        Spacer()
                        Text(String("\(weather.windDeg)°"))
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationBarTitle("Weather")
            .navigationBarTitleDisplayMode(.large)
        
    }
}
