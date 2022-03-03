//
//  SearchBar.swift
//  Finetic
//
//  Created by Tapiwa on 2021-04-28.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchUsers: String
    @State private var isSearching = false
    var body: some View {
        HStack {
            TextField("Search users here", text: $searchUsers)
        }
        .padding()
        .background(Color(.systemGray5))
        .cornerRadius(6.0)
        .padding(.horizontal)
        .onTapGesture {
            isSearching = true
        }
        .overlay(
            HStack {
                Image(systemName: "magnifyingglass")
                Spacer()
                
                Button(action: {searchUsers = ""}) {
                    Image(systemName: "xmark.circle")

                }

            }
            .padding(.horizontal, 32)
            .foregroundColor(.gray)
        )
    }
}


