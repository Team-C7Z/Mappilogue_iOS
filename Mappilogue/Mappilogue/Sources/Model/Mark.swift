//
//  Mark.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/29.
//

import Foundation
import UIKit

struct Mark {
    let title: String
    let color: UIColor
    let date: String?
    let location: String?
}

func dummyMarkData() -> [Mark] {
    let mark1 = Mark(title: "서울숲 소풍", color: .colorFFA1A1, date: "5월 1일", location: "서울숲")
    let mark2 = Mark(title: "서울 맛집 여행", color: .colorB2EBE7, date: "9월 13일", location: "광장시장")

    return [mark1, mark2]
}
