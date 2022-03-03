//
//  PersonalWeeklyCard.swift
//  Finetic
//
//  Created by Tapiwa on 2021-05-03.
//

import SwiftUI

struct PersonalWeeklyCard: View {
    var body: some View {
        HStack {
            PersonalRingComponent(percent: 10, foregroundColor: Color.ui.blue)
            PersonalRingComponent(percent: 60, foregroundColor: Color.ui.green)
            PersonalRingComponent(percent: 90, foregroundColor: Color.ui.yellow)
        }
        .background(Color.ui.purple)
        .cornerRadius(20)
    }
}

struct PersonalWeeklyCard_Previews: PreviewProvider {
    static var previews: some View {
        PersonalWeeklyCard()
    }
}
