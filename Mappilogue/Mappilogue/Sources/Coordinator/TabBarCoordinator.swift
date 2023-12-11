//
//  TabBarCoordinator.swift
//  Mappilogue
//
//  Created by hyemi on 12/12/23.
//

import Foundation

class TabBarCoordinator: BaseCoordinator {
    override func start() {
        let tabBarController = TabBarController()
        navigationController.pushViewController(tabBarController, animated: false)
    }
}
