//
//  Location.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/17.
//

import Foundation

struct Location {
    let title: String
    let address: String
}

func dummyLocationData() -> [Location] {
    let location1 = Location(title: "서울특별시청", address: "서울특별시 중구 세종대로 110 서울특별시청")
    let location2 = Location(title: "서울특별시청서소문2청사", address: "서울특별시 중구 서소문로 124")
    let location3 = Location(title: "롯데월드 어드벤처", address: "서울특별시 송파구 올림픽로 240")
    let location4 = Location(title: "동대문디자인플라자", address: "서울특별시 중구 을지로 281")
    let location5 = Location(title: "여의도 한강공원", address: "서울특별시 영등포구 여의동로 330 한강사업본부 여의도 한강 여의도안내센터")
    let location6 = Location(title: "덕수궁", address: "서울특별시 중구 세종대로 99 덕수궁")
    
    let locations = [location1, location2, location3, location4, location5, location6]
    
    return locations
}

struct LocationTime {
    var date: String
    var locationDetail: [LocationTimeDetail]
}

struct LocationTimeDetail {
    var location: String
    var time: String
}

func dummyMainLocationData() -> [Location] {
    let mainLocation1 = Location(title: "제주도", address: "")
    let mainLocation2 = Location(title: "카멜리아힐", address: "제주 서귀포시 안덕면 병악로 166")
    let mainLocation3 = Location(title: "동관분교인디이스트", address: "제주 서귀포시 안덕면 동광로 107 서광초등학교동…")
    let mainLocation4 = Location(title: "오셜록 티 뮤지엄", address: "제주 서귀포시 안덕면 병악로 166")
    let mainLocation5 = Location(title: "제주국제공항", address: "제주 제주시 공항로 2 제주국제공항")

    return [mainLocation1, mainLocation2, mainLocation3, mainLocation4, mainLocation5]
}
