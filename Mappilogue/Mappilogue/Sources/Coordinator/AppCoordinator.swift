//
//  AppCoordinator.swift
//  Mappilogue
//
//  Created by hyemi on 12/11/23.
//

import UIKit

class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        if RootUserDefaults.isPermissionNeeded() {
            showPermissionViewController()
        } else if RootUserDefaults.isOnboardingNeeded() {
            showOnboardingViewController()
        } else {
            AuthUserDefaults.autoLogin { success in
                if success {
                    self.showTabBarController()
                } else {
                    self.showLoginViewController()
                }
            }
        }
    }
        
    func showPermissionViewController() {
        let permissionCoordinator = PermissionCoordinator(navigationController: navigationController)
        childCoordinators.append(permissionCoordinator)
        permissionCoordinator.start()
    }
    
    func showOnboardingViewController() {
        let onboardingCoordinator = OnboardingCoordinator(navigationController: navigationController)
        childCoordinators.append(onboardingCoordinator)
        onboardingCoordinator.start()
    }
    
    func showLoginViewController() {
        let loginCoordinator = LoginCoordinator(navigationController: navigationController)
        childCoordinators.append(loginCoordinator)
        loginCoordinator.start()
    }
    
    func showTabBarController() {
        let tabBarCoordinator = TabBarCoordinator(navigationController: navigationController)
        childCoordinators.append(tabBarCoordinator)
        tabBarCoordinator.start()
    }
}
