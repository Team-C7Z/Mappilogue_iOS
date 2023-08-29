//
//  ErrorResponse.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/28.
//

import Foundation

struct ErrorResponse: Codable {
    let isSuccess: Bool
    let errorCode: String
    let statusCode: Int
    let timestamp: String
    let path: String
}
