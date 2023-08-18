//
//  Category.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/31.
//

import Foundation

struct CategoryData {
    var title: String
    var count: Int
}

func dummyCategoryData() -> [CategoryData] {
    let category = [
        CategoryData(title: "휴가", count: 3),
        CategoryData(title: "생일", count: 11),
        CategoryData(title: "유진이랑 논 날💕", count: 6),
        CategoryData(title: "전시회", count: 0),
        CategoryData(title: "소풍", count: 2),
        CategoryData(title: "ㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠ", count: 1),
        CategoryData(title: "콘서트", count: 4),
        CategoryData(title: "여행", count: 9)
    ]
    
    return category
}
