//
//  CategorySettingCoordinator.swift
//  Mappilogue
//
//  Created by hyemi on 12/24/23.
//

import Foundation

protocol CategorySettingDelegate: AnyObject {
    func popViewController()
}

class CategorySettingCoordinator: AppCoordinator, CategorySettingDelegate {
    override func start() {
        let categorySettingController = CategorySettingViewController()
        categorySettingController.hidesBottomBarWhenPushed = true
        categorySettingController.coordinator = self
        navigationController.pushViewController(categorySettingController, animated: false)
    }
    
    func popViewController() {
        navigationController.popViewController(animated: false)
    }
}
