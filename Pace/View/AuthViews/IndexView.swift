//
//  IndexView.swift
//  Pace
//
//  Created by Tapiwa Kundishora on 2022-03-03.
//

import Foundation
import SwiftUI

struct IndexView: View {
    var body: some View {
        NavigationView {
            Image("index")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .overlay(IndexOverlay())
        }
  
            
    }
}

struct IndexOverlay: View {
    var body: some View {
        ZStack {
            VStack {
                HStack() {
                    Spacer()
                    NavigationLink(destination: SigninView()) {
                        Text("Sign in")
                            .bold()
                    }
                    .padding(.trailing, 40)
                    .offset(y: -80)
                }
               
                Spacer()
                NavigationLink(destination: SignupView()) {
                   
                        Text("Sign up")
                            .modifier(ButtonModifier())
                            .frame(width: 300)

                    

                }
                Text("Pace")
                    .font(.largeTitle)
                    .foregroundColor(Color.primary)
            }
          
        }
    }
}
