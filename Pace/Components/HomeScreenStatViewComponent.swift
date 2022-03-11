//
//  HomeScreenStatViewComponent.swift
//  Finetic
//
//  Created by Tapiwa on 2021-04-28.
//

import SwiftUI

struct HomeScreenStatViewComponent: View {
    var value: String
    var label: String
    var body: some View {
        VStack {
            Spacer()
            Spacer()
            HStack(alignment: .lastTextBaseline) {
                Text(value)
                    .font(.system(size: 62, weight: .bold))
                Text("km")
                    .font(.title3)
                    .bold()
            }
            Spacer()
            Text(label)
            Spacer()

        }
        .foregroundColor(.white)

        .frame(width: 180, height: 180)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.ui.gradientGreen1, Color.ui.gradientGreen2]), startPoint: .leading, endPoint: .trailing)
            )
        .cornerRadius(CGFloat(15))

    }
}


