//
//  ImagePickerCoordinator.swift
//  Mappilogue
//
//  Created by hyemi on 12/17/23.
//

import Foundation
import Photos

protocol ImagePickerDelegate: AnyObject {
    func showImagePickerViewController(authStatus: PHAuthorizationStatus, isProfile: Bool)
    func popViewController(assets: [PHAsset])
}

protocol ProfileImageDelegate: AnyObject {
    func changedProfileImage(assets: [PHAsset])
}

class ImagePickerCoordinator: BaseCoordinator, ImagePickerDelegate {
    weak var delegate: ProfileImageDelegate?
    
    override func start() {
        
    }
    
    func showImagePickerViewController(authStatus: PHAuthorizationStatus, isProfile: Bool) {
        let imagePickerViewController = ImagePickerViewController()
        imagePickerViewController.coordinator = self
        imagePickerViewController.authStatus = authStatus
        imagePickerViewController.isProfile = true
        imagePickerViewController.modalPresentationStyle = .fullScreen
        navigationController.pushViewController(imagePickerViewController, animated: false)
    }
    
    func popViewController(assets: [PHAsset]) {
        delegate?.changedProfileImage(assets: assets)
        navigationController.popViewController(animated: false)
    }
}
