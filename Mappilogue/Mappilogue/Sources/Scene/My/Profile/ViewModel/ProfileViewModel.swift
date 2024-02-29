//
//  ProfileViewModel.swift
//  Mappilogue
//
//  Created by hyemi on 12/9/23.
//

import UIKit

class ProfileViewModel {
    func updateNickname(nickname: String) {
        MyManager.shared.updateNickname(nickname: nickname) { _ in }
    }
    
    func updateProfileImage(image: Data) {
        MyManager.shared.updateProfileImage(profileImage: image) { _ in }
    }
}
