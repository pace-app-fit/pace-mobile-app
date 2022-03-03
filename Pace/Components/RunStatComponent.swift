//
//  RunStatComponent.swift
//  Finetic
//
//  Created by Tapiwa on 2021-04-26.
//

import SwiftUI

struct RunStatComponent: View {
    var label: String
    var value: String
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            Text(label)
                .foregroundColor(.secondary)
                .font(.subheadline)
            Text(value)
                .font(.headline)
                .italic()
                .bold()
                
        }    }
}


