//
//  HomeDTO.swift
//  Mappilogue
//
//  Created by hyemi on 2/26/24.
//

import Foundation

struct HomeDTO: Codable {
    let schedules: [Schedules]
    let marks: [Marks]
}

struct Schedules: Codable {
    let id: Int
    let colorId: Int
    let colorCode: String
    let title: String
    let areas: [Areas]
}

struct Areas: Codable {
    let id: Int
    let name: String
    let streetAddress: String
    let latitude: String
    let longitude: String
    let time: String
    let date: String
}

struct Marks: Codable {
    let id: Int
    let colorId: Int
    let markCategoryId: Int
    let title: String
    let colorCode: String
    let markCategoryTitle: String
    let markImageUrl: String
    let createdAt: String
}
