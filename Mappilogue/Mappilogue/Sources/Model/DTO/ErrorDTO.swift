//
//  ErrorDTO.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/28.
//

import Foundation

struct ErrorDTO: Codable {
    let isSuccess: Bool
    let statusCode: Int
    let errorCode: String
    let target: String
    let message: String
    let errorStack: String
    let timestamp: String
    let path: String
}
