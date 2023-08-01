//
//  Record.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/29.
//

import Foundation
import UIKit

struct Record {
    let title: String
    let image: String?
    let color: UIColor
    let date: String?
    let location: String?
    let category: String?
    let lat: Double?
    let lng: Double?
}

func dummyRecordData() -> [Record] {
    let record1 = Record(title: "서울숲 소풍", image: nil, color: .colorFFA1A1, date: "5월 1일", location: "서울숲", category: nil, lat: 37.502767, lng: 127.029723)
    let record2 = Record(title: "뉴진스 팝업 갔다가 쇼핑 너무 많이 해버렸다ㅠㅠㅠㅠㅠㅠㅠ", image: nil, color: .colorB2EBE7, date: "9월 1일", location: "여의도역", category: nil, lat: 37.503117, lng: 127.041953)
    let record3 = Record(title: "서울 맛집 여행", image: nil, color: .colorB2EBE7, date: "9월 13일", location: "광장시장", category: "여행", lat: nil, lng: nil)

    return [record1, record2, record3]
}
