//
//  AnnouncementDTO.swift
//  Mappilogue
//
//  Created by hyemi on 3/2/24.
//

import Foundation

struct AnnouncementDTO: Codable {
    var id: Int
    var title: String
    var content: String
    var createdAt: String
}

struct Meta: Codable {
    let pageNo: Int
    let pageSize: Int
    let itemCount: Int
    let pageCount: Int
    let hasPreviousPage: Bool
    let hasNextPage: Bool
}
