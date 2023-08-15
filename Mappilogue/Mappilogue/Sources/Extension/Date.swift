//
//  Date.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/10.
//

import Foundation

extension Date {
    func formatToMMddDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM월 dd일"
        return dateFormatter.string(from: self)
    }

    func formatTohmmaDateToString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: self)
    }
}
