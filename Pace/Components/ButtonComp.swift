//
//  ButtonComp.swift
//  Finetic
//
//  Created by Tapiwa on 2021-03-06.
//

import SwiftUI


struct ButtonModifier: ViewModifier {
    var backgroundColor: Color = Color.pink
    
    
    func body(content: Content) -> some View {
        content
            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            .frame(height: 15)
            .padding()
            .foregroundColor(.white)
            .font(.title2)
            .background(backgroundColor)
            .cornerRadius(60)
    }
}

extension View {
    func buttonModifier() -> some View {
        self.modifier(ButtonModifier())
    }
}
