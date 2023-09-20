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
        AnnouncementData(title: "맵필로그를 시작합니다.", date: "2023년 9월 1일", content: "맵필로그"),
        AnnouncementData(title: "맵필로그", date: "2023년 1월 27일", content: "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.")
    ]
    return announcement
}
