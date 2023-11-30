//
//  UserAPI.swift
//  Mappilogue
//
//  Created by hyemi on 2023/09/01.
//

import Foundation
import Moya
import Combine

protocol UserAPI {
    func getProfile() -> AnyPublisher<BaseDTO<ProfileDTO>, Error>
    func updateNickname(nickname: String) -> AnyPublisher<Void, Error>
    func updateProfileImage(image: Data) -> AnyPublisher<BaseDTO<ProfileImageDTO>, Error>
    func getNotificationSetting() -> AnyPublisher<BaseDTO<NotificationDTO>, Error>
    func updateNotificationSetting(notification: NotificationDTO) -> AnyPublisher<Void, Error>
    func getTermsOfUse() -> AnyPublisher<BaseDTO<TermsOfUserDTO>, Error>
}
