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
    var name: String
    
    var body: some View {
        Group {
            VStack(alignment: .leading) {
                Text(name)
                    .foregroundColor(.secondary)
                
                Group {
                    if isSecure {
                        SecureField(placeholder, text: $value )
                    } else {
                        TextField(placeholder, text: $value)
                            
                    }
                }
                .disableAutocorrection(true)
                .autocapitalization(.none)
                
            }
            .padding([.top, .bottom], 8)
            .padding(.leading)
            .background(Color(UIColor.systemGray5))
            .cornerRadius(8)
        }
        .padding(.top)
    }
}
