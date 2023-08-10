//
//  Date.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/10.
//

import Foundation

extension Date {
    func formatDateToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM월 dd일"
        return dateFormatter.string(from: self)
    }
}
