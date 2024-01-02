//
//  ContentCoordinator.swift
//  Mappilogue
//
//  Created by hyemi on 12/17/23.
//

import MappilogueKit

protocol ContentDelegate: AnyObject {
    func popViewController()
}

class ContentCoordinator: BaseCoordinator, ContentDelegate {
    override func start() {
        let contentViewController = ContentViewController()
        contentViewController.hidesBottomBarWhenPushed = true
        contentViewController.coordinator = self
        navigationController.pushViewController(contentViewController, animated: false)
    }
    
    func showWriteRecordViewController() {
        let coordinator = WriteRecordCoordinator(navigationController: self.navigationController)
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }
    
    func showEditBottomSheetViewController(modifyTitle: String, deleteTitle: String, alert: Alert) {
        let coordinator = EditBottomSheetCoordinator(navigationController: self.navigationController)
        coordinator.showEditBottomSheetViewController(modifyTitle: modifyTitle, deleteTitle: deleteTitle, alert: alert)
        self.childCoordinators.append(coordinator)
    }
    
    func showImageDetailViewController(imageName: String) {
        let coordinator = ImageDetailCoordinator(navigationController: self.navigationController)
        coordinator.showImageDetailViewController(imageName: imageName)
        self.childCoordinators.append(coordinator)
    }
    
    func popViewController() {
        navigationController.popViewController(animated: false)
    }
}
