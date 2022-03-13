//
//  WeatherCard.swift
//  Finetic
//
//  Created by Tapiwa on 2021-04-29.
//

import SwiftUI
import MapKit
import CoreLocation

struct WeatherCard: View {
    @ObservedObject var weatherClient = WeatherService()
    let locationManager = CLLocationManager()
    @State var weather: Weather?
    @State var city = ""
    @State var state = ""

    
    var body: some View {
        HStack {
            if let weather = weather {
                Spacer()

                VStack {
                    Text("\(city), \(state)")
                        .font(.callout)
                        .bold()
                        .foregroundColor(Color.blue)
                    
                    Text("\(Int(weather.current.feelsLike))°")
                        .font(.system(size: 46, weight: .bold))
                        .foregroundColor(.white)

                    Spacer()
                    Text(weather.current.weather.first?.weatherDescription ?? "")
                        .foregroundColor(.white)
                }
                Spacer()
                VStack {
                    HStack {
                        VStack {
                            Text(getHour(date: weather.hourly[1].dt))
                            Spacer()
                            Text("\(Int(weather.hourly[1].feelsLike))°")
                                .font(.title2)
                                .bold()
                            Spacer()
                            Spacer()
                        }
                        Spacer()
                        VStack {
                            Text(getHour(date: weather.hourly[2].dt))
                            Spacer()
                            Text("\(Int(weather.hourly[2].feelsLike))°")
                                .font(.title2)
                                .bold()
                            Spacer()
                            Spacer()
                        }
                        Spacer()
                        VStack {
                            Text(getHour(date: weather.hourly[3].dt))
                            Spacer()
                            Text("\(Int(weather.hourly[3].feelsLike))°")
                                .font(.title2)
                                .bold()
                            Spacer()
                            Spacer()
                        }
                        Spacer()
                        VStack {
                            Text(getHour(date: weather.hourly[4].dt))
                            Spacer()
                            Text("\(Int(weather.hourly[4].feelsLike))°")
                                .font(.title2)
                                .bold()
                            Spacer()
                            Spacer()
                        }
                    }
                    Divider()
                        .frame(width: 100)
                        .foregroundColor(.white)
                    Spacer()
                    Text(getDate(date: weather.current.dt))
                }
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                Spacer()
            } else {
                Text("No Weather data...")
                    .foregroundColor(.white)
            }
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 10)
        .frame(maxWidth: .infinity, idealHeight: 150)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.ui.gradientBlue1, Color.ui.gradientBlue2]), startPoint: .leading, endPoint: .trailing)
            )
        .cornerRadius(25)
        .onAppear{
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
            if let location = locationManager.location {
                getUserLocation(for: CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude))
                weatherClient.getWeather(lat: String(format: "%f",location.coordinate.latitude), long: String(format: "%f",location.coordinate.longitude)) { weather in
                    self.weather = weather
            }
            }
        }
    }
    
    func getUserLocation(for location: CLLocation) {
            
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(location) { placemarks, error in
                
                guard error == nil else {
                    print("*** Error in \(#function): \(error!.localizedDescription)")
                    return
                }
                
                guard let placemark = placemarks?[0] else {
                    print("*** Error in \(#function): placemark is nil")
                    return
                }
                
                if let city = placemark.locality {
                    self.city = city
                }
                
                if let state = placemark.administrativeArea {
                    self.state = state
                }
            }
        }
    
    func getHour(date: Int) -> String {
        let d = Date(timeIntervalSince1970: Double(date))
        return String(Calendar.current.component(.hour, from: d))
    }
    
    func getDate(date: Int) -> String {
        let d = Date(timeIntervalSince1970: Double(date))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E MMMM d, yyyy"
        return dateFormatter.string(from: d)
    }
}
