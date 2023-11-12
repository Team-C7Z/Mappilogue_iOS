//
//  GetCategoryDTO.swift
//  Mappilogue
//
//  Created by hyemi on 2023/11/03.
//

import Foundation

struct GetCategoryDTO: Codable {
    let totalCategoryMarkCount: Int
    let markCategories: [Category]
}

struct Category: Codable {
    var id: Int
    var title: String
    var isMarkedInMap: MarkedInMapStatus
    let markCount: Int
}

enum MarkedInMapStatus: String, Codable {
    case active = "ACTIVE"
    case inactive = "INACTIVE"
}
