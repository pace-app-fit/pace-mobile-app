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
                    HStack() {
                        Spacer()
                        NavigationLink(destination: SigninView(auth: _auth)) {
                            Text("Sign in")
                                .bold()
                        }
                        .padding(.trailing, 40)
                        .offset(y: -80)
                    }
                    Spacer()
                    NavigationLink(destination: SigninView()) {
                        Text("Sign in")
                            .modifier(ButtonModifier())
                            .frame(width: 300)

                    }
           
                }
              
            }
          
        }
  
            
    }
}


