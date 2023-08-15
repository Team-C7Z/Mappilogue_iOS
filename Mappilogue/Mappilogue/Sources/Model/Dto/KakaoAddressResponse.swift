//
//  KakaoAddressResponse.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/15.
//

import Foundation

struct KakaoAddressResponse: Codable {
    let documents: [AddressDocuments]
}

struct AddressDocuments: Codable {
    let roadAddress: RoadAddress?
    let address: Address

    enum CodingKeys: String, CodingKey {
        case roadAddress = "road_address"
        case address
    }
}

struct RoadAddress: Codable {
    let addressName: String

    enum CodingKeys: String, CodingKey {
        case addressName = "address_name"
    }
}

struct Address: Codable {
    let addressName: String?

    enum CodingKeys: String, CodingKey {
        case addressName = "address_name"
    }
}
