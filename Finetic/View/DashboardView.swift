//
//  DashboardView.swift
//  Finetic
//
//  Created by Tapiwa on 2021-02-26.
//

import SwiftUI
struct DashboardView: View {
    
    
    var body: some View {
        VStack(alignment: .leading) {
            WeatherCard()
                .padding()
                 
             ScrollView(.horizontal, showsIndicators: false) {
                         HStack {
                         HomeScreenStatViewComponent(color: Color.pink)
                         HomeScreenStatViewComponent(color: Color.purple)
                         HomeScreenStatViewComponent(color: Color.blue)

                     }
                 }
                 .navigationTitle("Dashboard")
        }
           
          
        
       
        
       
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
