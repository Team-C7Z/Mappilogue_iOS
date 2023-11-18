//
//  ProfileDTO.swift
//  Mappilogue
//
//  Created by hyemi on 2023/09/05.
//

import Foundation

struct ProfileDTO: Codable {
    let nickname: String
    let email: String
    let profileImageUrl: String?
    let snsType: String
}
