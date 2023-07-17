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
    let location: String
    let time: String?
}

func dummyLocationTimeData(_ locationCount: Int) -> [LocationTime] {
    if locationCount == 0 {
        return []
    } else {
        let locationTime1 = LocationTime(location: "한강", time: "1:00 PM")
        let locationTime2 = LocationTime(location: "선릉역", time: "4:00 PM")
        
        return [locationTime1, locationTime2]
    }
}
