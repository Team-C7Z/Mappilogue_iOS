//
//  SelectedDate.swift
//  Mappilogue
//
//  Created by hyemi on 2023/09/24.
//

import Foundation

struct SelectedDate {
    var year: Int
    var month: Int
    var day: Int?
    
    func stringFromSelectedDate() -> String {
        let dateString = String(format: "%04d-%02d-%02d", year, month, day ?? 0)
        return dateString
    }
}
