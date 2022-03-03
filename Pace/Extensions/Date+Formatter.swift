//
//  Date+Formatter.swift
//  Finetic
//
//  Created by Tapiwa on 2021-04-26.
//

import Foundation

extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}
