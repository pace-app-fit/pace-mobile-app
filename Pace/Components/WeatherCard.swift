//
//  WeatherCard.swift
//  Finetic
//
//  Created by Tapiwa on 2021-04-29.
//

import SwiftUI

struct WeatherCard: View {
    @ObservedObject var weatherClient = WeatherService()
    @ObservedObject var locationCoordinater = NewRunCoordinator()
    
    var body: some View {
        HStack {
            if let weather = weatherClient.weather {
                VStack {
                    Text("Calgary, AB")
                        .font(.caption)
                    Text("\(Int(weather.current.temp))°")
                        .font(.system(size: 46, weight: .bold))

                    Spacer()
                    Text(weather.current.weather.first?.weatherDescription ?? "")
                }
                VStack {
                    HStack {
                        VStack {
                            Text("08")
                            Text("16^")
                        }
                        VStack {
                            Text("08")
                            Text("16^")
                        }
                        VStack {
                            Text("08")
                            Text("16^")
                        }
                        VStack {
                            Text("08")
                            Text("16^")
                        }
                    }
                    Divider()
                    Text("Tuesday March 23, 2022")
                }
            } else {
                Text("No Weather data...")
            }
        }
        .padding()
        .frame(height: 150)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.ui.gradientBlue1, Color.ui.gradientBlue2]), startPoint: .leading, endPoint: .trailing)
            )
        .cornerRadius(25)
//        .onAppear{
//            locationCoordinater.getCity(for: <#T##CLLocation#>)
//            weatherClient.getWeather(lat: locationCoordinater.region?.center.latitude, long: "-114.1157383193393")
//        }
    }
}
