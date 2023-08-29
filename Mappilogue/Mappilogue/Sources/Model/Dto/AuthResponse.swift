//
//  AuthResponse.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/27.
//

import Foundation

struct AuthResponse: Codable {
    let accessToken: String
    let refreshToken: String
}
