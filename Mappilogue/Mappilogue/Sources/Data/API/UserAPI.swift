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
    func updateNickname(nickname: String) -> AnyPublisher<Void, Error>
    func updateProfileImage(image: Data) -> AnyPublisher<BaseDTOResult<ProfileImageDTO>, Error>
    func getNotificationSetting() -> AnyPublisher<BaseDTOResult<NotificationDTO>, Error>
    func updateNotificationSetting(notification: NotificationDTO) -> AnyPublisher<Void, Error>
    func getTermsOfUse() -> AnyPublisher<BaseDTOResult<TermsOfUserDTO>, Error>
}

