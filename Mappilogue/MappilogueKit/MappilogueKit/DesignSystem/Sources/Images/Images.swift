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
        case onboardingCurrentPage = "onboarding _current_page"
        case onboardingPage = "onboarding_page"
        case buttonKakaoLogin = "button_kakao_login"
        case buttonAppleLogin = "button_apple_login"
        case buttonAdd = "button_add"
        case buttonAddSchedule = "button_add_schedule"
        case toastGathering = "toast_gathering"
        case toastGatheringArrow = "toast_gathering_arrow"
        case toastDelete = "toast_delete"
    }
    
    static public func image(named: Image) -> UIImage {
        return .load(name: named.rawValue)
    }
}
