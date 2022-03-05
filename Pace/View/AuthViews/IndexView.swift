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
                            Image(systemName: "chevron.right")
                        }
                        .foregroundColor(Color.white)

                        .padding(.trailing, 80)
                    }
                    
                    Image("pace_text")
                        .offset(y: 400)
                

                   
                   
                    
                    Spacer()
                    NavigationLink(destination: SignupView(auth: _auth)) {
                        Text("Get started")
                            .modifier(ButtonModifier())
                            .frame(width: 300)
                    }
                }
            }
            .navigationBarHidden(true)
            .statusBar(hidden: true)
        }
    }
}


