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
    let record1 = Record(title: "압구정로데오거리", image: "recordTest1", color: .colorFFA1A1, date: "5월 1일", location: "압구정로데오거리", category: "생일", lat: 37.5267558230172, lng: 127.039152029523)
    let record2 = Record(title: "벚꽃구경", image: "recordTest2", color: .colorB2EBE7, date: "9월 1일", location: "양재천 벚꽃길", category: "유진이랑 논 날💕", lat: 37.4818037639471, lng: 127.04659518891)
    let record3 = Record(title: "신사동 가로수길", image: "recordTest3", color: .colorF0F1B0, date: "9월 13일", location: "신사동가로수길", category: "생일", lat: 37.5211558694563, lng: 127.022836977184)
    let record4 = Record(title: "코엑스 구경", image: nil, color: .colorE6C3F2, date: "3월 11일", location: "코엑스", category: "전시회", lat: 37.51266138067201, lng: 127.05882784390123)
    let record5 = Record(title: "덕수궁", image: "recordTest1", color: .colorB2EAD6, date: "4월 5일", location: "덕수궁", category: "생일", lat: 37.5655638710672, lng: 126.974894754989)
    let record6 = Record(title: "여의도 공원", image: nil, color: .colorB2EBE7, date: "9월 12일", location: "여의도 공원", category: "전시회", lat: 37.5250892160129, lng: 126.947545050571)
    let record7 = Record(title: "경북궁", image: "recordTest3", color: .colorCAEDA8, date: "12월 7일", location: "경북궁", category: "휴가", lat: 37.577613288258206, lng: 126.97689786832184)
    let record8 = Record(title: "남산 서울 타워", image: "recordTest2", color: .colorC9C6C2, date: "1월 17일", location: "남산 서울 타워", category: "휴가", lat: 37.55127433407266, lng: 126.98820799353979)
    let record9 = Record(title: "서울숲", image: nil, color: .colorF5DC82, date: "2월 23일", location: "서울숲", category: "휴가", lat: 37.5443222301513, lng: 127.037617759165)
    
    return [record1, record2, record3, record4, record5, record6, record7, record8, record9]
}
