//
//  RunInProgressView.swift
//  Finetic
//
//  Created by Tapiwa on 2021-04-26.
//

import SwiftUI

struct RunInProgressView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        GeometryReader { geo in
            VStack {
                Spacer()
                Text("4:15")
                    .font(.system(size: 84))
                    .bold()
                    .italic()
                    .foregroundColor(.white)
                Text("Time")
                    .font(.largeTitle)
                    .foregroundColor(.secondary)
                Spacer()
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Stop Run")
                })
                .modifier(ButtonModifier())
                .frame(width: geo.size.width * 0.5)
                Spacer()
            }
            
            .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
            .scaledToFit()
            
            .background(Color.green)
        }
        .edgesIgnoringSafeArea(.all)
       
        
        
        
    }
    
}

struct RunInProgressView_Previews: PreviewProvider {
    static var previews: some View {
        RunInProgressView()
    }
}
