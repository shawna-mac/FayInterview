//
//  Date+Extension.swift
//  FayInterview
//
//  Created by Shawna MacNabb on 6/14/25.
//

import Foundation

extension Date {
    var monthString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        return formatter.string(from: self)
    }

    var dayString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: self)
    }

    var isInThePast: Bool {
        self < Date()
    }
}
