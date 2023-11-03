//
//  GetCategoryDTO.swift
//  Mappilogue
//
//  Created by hyemi on 2023/11/03.
//

import Foundation

struct GetCategoryDTO: Codable {
    let totalCategoryMarkCount: Int
    let categories: [Category]
}

struct Category: Codable {
    var id: Int
    var title: String
    let isMarkInMap: String
    let markCount: Int
}
