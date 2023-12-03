//
//  Images.swift
//  MappilogueKit
//
//  Created by hyemi on 2023/12/02.
//

import UIKit

public class Images {
    static let bundle = Bundle(for: Images.self)
    
    public enum Image: String {
        case imageOnboardingCurrentPage = "image_onboarding_current_page"
        case imageOnboardingPage = "image_onboarding_page"
        case imageKakaoLoginAccount = "image_kakao_login_account"
        case imageAppleLoginAccount = "image_apple_login_account"
        case imageNotificationEmpty = "image_notification_empty"
        case imageHeartMark = "image_heart_mark"
        case imageAddMarkedRecord = "image_add_marked_record"
        case buttonKakaoLogin = "button_kakao_login"
        case buttonAppleLogin = "button_apple_login"
        case buttonExpand = "button_expand"
        case buttonClose = "button_close"
        case buttonRemove = "button_remove"
        case buttonAdd = "button_add"
        case buttonAddSchedule = "button_add_schedule"
        case buttonWriteRecord = "button_write_record"
        case buttonMyRecord = "button_my_record"
        case toastGathering = "toast_gathering"
        case toastGatheringArrow = "toast_gathering_arrow"
        case toastDelete = "toast_delete"
    }
    
    static public func image(named: Image) -> UIImage {
        return .load(name: named.rawValue)
    }
}
