//
//  HomeScreenStatViewComponent.swift
//  Finetic
//
//  Created by Tapiwa on 2021-04-28.
//

import SwiftUI

struct HomeScreenStatViewComponent: View {
    var color: Color
    var body: some View {
        VStack {
            
            Text("45")
                .font(.system(size: 82))
                .foregroundColor(Color.white)
            Text("label")
        }
        .frame(width: 170, height: 210)
        .background(color)
        .cornerRadius(CGFloat(15))

    }
}


