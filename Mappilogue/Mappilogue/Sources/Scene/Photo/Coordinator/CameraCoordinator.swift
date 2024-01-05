//
//  CameraCoordinator.swift
//  Mappilogue
//
//  Created by hyemi on 12/25/23.
//

import UIKit

protocol CameraDelegate: AnyObject {
    func popViewController()
}

class CameraCoordinator: BaseCoordinator, CameraDelegate {
    override func start() {
        let cameraViewController = CameraViewController()
        cameraViewController.coordinator = self
        navigationController.pushViewController(cameraViewController, animated: false)
    }
    
    func showCapturePhotoViewController(photo: UIImage) {
        let coordinator =
        CapturePhotoCoordinator(navigationController: self.navigationController)
        coordinator.showCapturePhotoViewController(photo: photo)
        self.childCoordinators.append(coordinator)
    }
    
    func popViewController() {
        childDidFinish(self)
        navigationController.popViewController(animated: false)
    }
}
