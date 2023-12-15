//
//  TabBarCoordinator.swift
//  Mappilogue
//
//  Created by hyemi on 12/12/23.
//

import Foundation

protocol TabBarDelegate: AnyObject {
    func presentTabBarController()
}

class TabBarCoordinator: BaseCoordinator, TabBarDelegate {
    let tabBarController = TabBarController()
    
    override func start() {
        presentTabBarController()
    }
    
    func presentTabBarController() {
        tabBarController.coordinator = self
        tabBarController.modalPresentationStyle = .fullScreen
        navigationController.present(tabBarController, animated: false)
//        navigationController.isNavigationBarHidden = true
//        navigationController.pushViewController(tabBarController, animated: false)
    }
}
