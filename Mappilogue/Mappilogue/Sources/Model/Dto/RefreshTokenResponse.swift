//
//  RefreshTokenResponse.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/31.
//

import Foundation

struct RefreshTokenResponse: Codable {
    let accessToken: String
    let refreshToken: String
}
