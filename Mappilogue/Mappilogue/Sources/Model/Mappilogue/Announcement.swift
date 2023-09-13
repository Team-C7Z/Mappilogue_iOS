//
//  Announcement.swift
//  Mappilogue
//
//  Created by hyemi on 2023/09/13.
//

import UIKit

struct AnnouncementData {
    var title: String
    var date: String
    var content: String
}

func dummyAnnouncementData() -> [AnnouncementData] {
    let announcement = [
        AnnouncementData(title: "기록 어플 ‘맵필로그’ 런칭 안내", date: "2023년 9월 13일", content: "안녕하세요. 맵필로그 팀입니다.\n오랫동안 기획하여 준비한 어플을 새롭게 런칭하게 되었습니다.\n많은 관심 부탁드립니다. 감사합니다."),
        AnnouncementData(title: "맵필로그를 시작합니다.", date: "2023년 9월 1일", content: "맵필로그")
    ]
    return announcement
}
