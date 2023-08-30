//
//  AuthResponse.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/27.
//

import Foundation

struct AuthResponse: Codable {
    let type: String
    let accessToken: String
    let refreshToken: String
}
