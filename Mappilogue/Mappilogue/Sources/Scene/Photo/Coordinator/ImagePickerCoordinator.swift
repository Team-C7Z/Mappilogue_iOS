//
//  ImagePickerCoordinator.swift
//  Mappilogue
//
//  Created by hyemi on 12/17/23.
//

import MappilogueKit
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
    
    func showCameraPermissionAlert(alert: Alert) {
        let coordinator = AlertCoordinator(navigationController: self.navigationController)
        coordinator.showAlert(alert)
        self.childCoordinators.append(coordinator)
    }
    
    func showCameraViewController() {
        let coordinator = CameraCoordinator(navigationController: self.navigationController)
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }
    
    func popViewController(assets: [PHAsset]) {
        delegate?.changedProfileImage(assets: assets)
        childDidFinish(self)
        navigationController.popViewController(animated: false)
    }
}
