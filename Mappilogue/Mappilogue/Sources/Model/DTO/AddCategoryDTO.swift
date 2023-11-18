//
//  AddCategoryDTO.swift
//  Mappilogue
//
//  Created by hyemi on 2023/11/03.
//

import Foundation

struct AddCategoryDTO: Codable {
    let markCategoryId: Int
    let title: String
    let sequence: Int
}
