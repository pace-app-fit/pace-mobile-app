//
//  IndexView.swift
//  Pace
//
//  Created by Tapiwa Kundishora on 2022-03-03.
//

import Foundation
import SwiftUI

struct IndexView: View {
    @EnvironmentObject var auth: SessionStore
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("index")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                VStack {
                    HStack {
                        Spacer()
                        NavigationLink(destination: SigninView(auth: _auth)) {
                            Text("Sign in")
                                .bold()
                                .foregroundColor(Color.white)
                        }
                        .padding(.trailing, 40)
                    }
                   
                   
                    
                    Spacer()
                    NavigationLink(destination: SignupView(auth: _auth)) {
                        Text("Sign up")
                            .modifier(ButtonModifier())
                            .frame(width: 300)
                    }
                }
            }
        }
    }
}


