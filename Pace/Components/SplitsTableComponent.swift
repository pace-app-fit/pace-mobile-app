//
//  SplitsTableComponent.swift
//  Finetic
//
//  Created by Tapiwa on 2021-04-26.
//

import SwiftUI

struct SplitsTableComponent: View {
    var data: [UnitAnalysis]
    @Environment(\.defaultMinListRowHeight) var minRowHeight

    var body: some View {
        HStack(spacing: spacing ) {
            Text("KM")
            Text("Elevation")
            Text("Pace")
        }
        ForEach(data, id: \.self) { row in
            UnitDataRow(rowData: row, spacing: spacing)
        }
        .frame(minHeight: minRowHeight )
        
    }
    
    var spacing = CGFloat(15)
}

struct UnitDataRow: View {
    var rowData: UnitAnalysis
    var spacing: CGFloat
    var body: some View {
        HStack(spacing: spacing) {
            Text(rowData.kmAsString)
            Text(rowData.elevationAsString)
            Text(rowData.paceAsString)
    
        }
    }
}

