//
//  String.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/11.
//

import Foundation

extension String {
    func formatTohmmaStringToDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.date(from: self) ?? Date()
    }
    
    func formatToMMddDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = "MM월 d일"
            return dateFormatter.string(from: date)
        }
        return ""
    }
}
