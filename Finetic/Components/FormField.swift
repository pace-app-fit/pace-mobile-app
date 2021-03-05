//
//  FormField.swift
//  Finetic
//
//  Created by Tapiwa on 2021-03-04.
//

import SwiftUI

struct FormField: View {
    @Binding var value: String
    var icon: String
    var placeholder: String
    var isSecure = false
    
    var body: some View {
        Group {
            HStack {
                Image(systemName: icon).padding()
                Group {
                    if isSecure {
                        SecureField(placeholder, text: $value )
                    } else {
                        TextField(placeholder, text: $value)
                            
                    }
                }
                .padding()
                .background(Color("flash-white"))
                .cornerRadius(4)
                .font(.system(size: 26))
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 0))
                .disableAutocorrection(true)
                .autocapitalization(.none)
                
            }
        }
    }
}


