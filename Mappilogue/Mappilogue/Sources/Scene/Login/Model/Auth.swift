//
//  Auth.swift
//  Mappilogue
//
//  Created by hyemi on 2023/09/18.
//

import Foundation

struct Auth: Codable {
    var socialAccessToken: String
    var socialVendor: String
    var fcmToken: String?
    var isAlarmAccept: String?
}
