//
//  WeatherCard.swift
//  Finetic
//
//  Created by Tapiwa on 2021-04-29.
//

import SwiftUI

struct WeatherCard: View {
    var body: some View {
        VStack {
            HStack {
                Text("Calgary")
                Spacer()
                Text("8:45 pm")
            }
            Text("13 C")
        }
        .frame(height: 150)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.ui.blue, Color.ui.green]), startPoint: .leading, endPoint: .trailing)
            )
        .cornerRadius(25)
    }
}

struct WeatherCard_Previews: PreviewProvider {
    static var previews: some View {
        WeatherCard()
    }
}
