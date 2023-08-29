//
//  BaseResponse.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/27.
//

import Foundation

struct BaseResponse<T: Codable>: Codable {
    var isSuccess: Bool
    var statusCode: Int
    var result: T?
}
