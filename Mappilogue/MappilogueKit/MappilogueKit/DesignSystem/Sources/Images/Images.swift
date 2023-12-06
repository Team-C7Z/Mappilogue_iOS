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
        case imagePermissionCamera = "image_permission_camera"
        case imagePermissionImage = "image_permission_image"
        case imagePermissionLocation = "image_permission_location"
        case imagePermissionNotification = "image_permission_notification"
        case imageOnboardingCurrentPage = "image_onboarding_current_page"
        case imageOnboardingPage = "image_onboarding_page"
        case imageSignupCompletion = "image_signup_completion"
        case imageKakaoLoginAccount = "image_kakao_login_account"
        case imageAppleLoginAccount = "image_apple_login_account"
        case imageNotificationEmpty = "image_notification_empty"
        case imageHeartMark = "image_heart_mark"
        case imageAddMarkedRecord = "image_add_marked_record"
        case imagePin = "image_pin"
        case imageModify = "image_modify"
        case imageDelete = "image_delete"
        case imageOrder = "image_order"
        case imageMainLocation = "image_main_location"
        case imageMainLocationPin = "image_main_location_pin"
        case imagePinFill = "image_pin_fill"
        case imageCurrentLocation = "image_current_location"
        case imageDeleteLocation = "image_delete_location"
        case imageBottomSheetBar = "image_bottom_sheet_bar"
        case imageCheckColor = "image_check_color"
        case imageTime = "image_time"
        case imageSearch = "image_search"
        case imageSeparator = "image_separator"
        case buttonKakaoLogin = "button_kakao_login"
        case buttonAppleLogin = "button_apple_login"
        case buttonExpand = "button_expand"
        case buttonClose = "button_close"
        case buttonDelete = "button_delete"
        case buttonCheck = "button_check"
        case buttonUncheck = "button_uncheck"
        case buttonEdit = "button_edit"
        case buttonAdd = "button_add"
        case buttonAddSchedule = "button_add_schedule"
        case buttonWriteRecord = "button_write_record"
        case buttonMoveCurrentLocation = "button_move_current_location"
        case buttonMyRecord = "button_my_record"
        case buttonCheckTime = "button_check_Time"
        case buttonAddPhoto = "button_add_photo"
        case buttonCamera = "button_camera"
        case buttonCameraCapture = "button_camera_capture"
        case buttonChangeCameraMode = "button_change_camera_mode"
        case buttonDismissImage = "button_dismiss_image"
        case buttonHideKey = "button_hide_keyboard"
        case toastGathering = "toast_gathering"
        case toastGatheringArrow = "toast_gathering_arrow"
        case toastDelete = "toast_delete"
        case tabbarCalendar = "tabbar_calendar"
        case tabbarGathering = "tabbar_gathering"
        case tabbarHome = "tabbar_home"
        case tabbarMy = "tabbar_my"
        case tabbarRecord = "tabbar_record"
    }
    
    static public func image(named: Image) -> UIImage {
        return .load(name: named.rawValue)
    }
}
