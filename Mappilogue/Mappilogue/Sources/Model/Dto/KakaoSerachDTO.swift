//
//  KakaoSerachDTO.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/16.
//

import Foundation

struct KakaoSerachDTO: Codable {
    let kakaoSearchPlaces: [KakaoSearchPlaces]
    
    enum CodingKeys: String, CodingKey {
        case kakaoSearchPlaces = "documents"
    }
}

struct KakaoSearchPlaces: Codable {
    let placeName: String
    let addressName: String
    let long, lat: String
    
    enum CodingKeys: String, CodingKey {
        case placeName = "place_name"
        case addressName = "address_name"
        case long = "x"
        case lat = "y"
    }
}
