//
//  ImageDetailCoordinator.swift
//  Mappilogue
//
//  Created by hyemi on 1/2/24.
//

import Foundation

protocol ImageDetailDelegate: AnyObject {
    func dismissViewController()
}

class ImageDetailCoordinator: BaseCoordinator, ImageDetailDelegate {
    override func start() {}
    
    func showImageDetailViewController(imageName: String) {
        let imageDetailViewController = ImageDetailViewController()
        imageDetailViewController.modalPresentationStyle = .overCurrentContext
        imageDetailViewController.coordinator = self
        navigationController.present(imageDetailViewController, animated: false)
    }
    
    func dismissViewController() {
        childDidFinish(self)
        navigationController.dismiss(animated: false)
    }
}
