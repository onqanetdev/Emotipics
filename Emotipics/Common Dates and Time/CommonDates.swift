//
//  CommonDates.swift
//  Emotipics
//
//  Created by Onqanet on 11/06/25.
//

import Foundation



class CommonDates {
    
   static let sharedCommonDates = CommonDates()
    
    func compareDates(_ dateString: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        guard let inputDate = inputFormatter.date(from: dateString) else {
            return "Invalid date"
        }
        
        let now = Date()
        let calendar = Calendar.current

        let components = calendar.dateComponents([.month, .day, .hour, .minute], from: inputDate, to: now)
        
        if let months = components.month, months >= 1 {
            return "\(months) month(s) ago"
        } else if let days = components.day, days >= 1 {
            return "\(days) day(s) ago"
        } else if let hours = components.hour, hours >= 1 {
            if let minutes = components.minute, minutes > 0 {
                return "\(hours)h \(minutes)m ago"
            } else {
                return "\(hours)h ago"
            }
        } else if let minutes = components.minute, minutes >= 1 {
            return "\(minutes)m ago"
        } else {
            return "Just now"
        }
    }
}



