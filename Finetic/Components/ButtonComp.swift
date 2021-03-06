//
//  ButtonComp.swift
//  Finetic
//
//  Created by Tapiwa on 2021-03-06.
//

import SwiftUI


struct ButtonComp: View {
    
    @State var text: String
    @State var color: Color
    
    var body: some View {
        VStack {
            Button(action: {
                
            }, label: {
                Text(text)
                    .font(.title)
                    .frame(width: 200)
                    .foregroundColor(.white)
                    .padding(.vertical, 10)
            })
            .background(
                Capsule()
                    .fill(color)
            )
        }
    }
}
