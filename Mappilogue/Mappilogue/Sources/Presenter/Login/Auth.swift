//
//  Auth.swift
//  Mappilogue
//
//  Created by hyemi on 2023/09/18.
//

import Foundation

struct Auth {
    var socialAccessToken: String
    var socialVendor: AuthVendor
    var fcmToken: String?
    var isAlarmAccept: ActiveStatus?
}
