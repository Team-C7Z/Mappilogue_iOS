//
//  BaseDTO.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/27.
//

import Foundation

struct BaseDTOResult<T: Codable>: Codable {
    var isSuccess: Bool
    var statusCode: Int
    var result: T?
}

struct BaseDTO: Codable {
    var isSuccess: Bool
    var statusCode: Int
}
