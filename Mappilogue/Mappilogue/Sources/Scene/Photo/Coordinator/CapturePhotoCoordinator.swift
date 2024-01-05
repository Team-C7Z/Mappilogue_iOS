//
//  CapturePhotoCoordinator.swift
//  Mappilogue
//
//  Created by hyemi on 12/25/23.
//

import UIKit

protocol CapturePhotoDelegate: AnyObject {
    func popViewController()
}

class CapturePhotoCoordinator: BaseCoordinator, CameraDelegate {
    override func start() {
       
    }
    
    func showCapturePhotoViewController(photo: UIImage) {
        let capturePhotoViewController = CapturePhotoViewController()
        capturePhotoViewController.coordinator = self
        capturePhotoViewController.configure(photo)
        navigationController.pushViewController(capturePhotoViewController, animated: false)
    }
    
    func popViewController() {
        childDidFinish(self)
        navigationController.popViewController(animated: false)
    }
}
