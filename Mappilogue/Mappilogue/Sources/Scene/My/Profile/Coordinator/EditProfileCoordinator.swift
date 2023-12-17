//
//  EditProfileCoordinator.swift
//  Mappilogue
//
//  Created by hyemi on 12/17/23.
//

import Foundation
import MappilogueKit
import Photos

protocol EditProfileDelegate: AnyObject {
    func showEditProfileViewController(_ profile: ProfileDTO?)
    func showEditNicknameModalViewController(_ nickname: String?)
    func popViewController()
    func dismissViewController()
}

class EditProfileCoordinator: BaseCoordinator, EditProfileDelegate {
    let editProfileViewController = EditProfileViewController()
    
    override func start() {
        
    }
    
    func showEditProfileViewController(_ profile: ProfileDTO?) {
        editProfileViewController.hidesBottomBarWhenPushed = true
        editProfileViewController.coordiantor = self
        if let profile = profile {
            editProfileViewController.configure(profile)
        }
        navigationController.pushViewController(editProfileViewController, animated: false)
    }
    
    func showEditNicknameModalViewController(_ nickname: String?) {
        let coordinator = EditNicknameCoordinator(navigationController: navigationController)
        coordinator.showEditNicknameModalViewController(nickname)
        coordinator.delegate = self
        childCoordinators.append(coordinator)
    }
    
    func showImagePickerViewController(authStatus: PHAuthorizationStatus, isProfile: Bool) {
        let coordinator = ImagePickerCoordinator(navigationController: navigationController)
        coordinator.showImagePickerViewController(authStatus: authStatus, isProfile: isProfile)
        coordinator.delegate = self
        childCoordinators.append(coordinator)
    }
    
    func popViewController() {
        navigationController.popViewController(animated: true)
    }
    
    func dismissViewController() {
        navigationController.dismiss(animated: false)
    }
}

extension EditProfileCoordinator: NicknameDelegate {
    func changedNickname(nickname: String) {
        editProfileViewController.changeNickname(nickname)
    }
}

extension EditProfileCoordinator: ProfileImageDelegate {
    func changedProfileImage(assets: [PHAsset]) {
        if let asset = assets.first {
            self.editProfileViewController.updateProfileAssetImage(asset)
        }
    }
}
