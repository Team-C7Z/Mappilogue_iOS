//
//  TabBarRouter.swift
//  Mappilogue
//
//  Created by hyemi on 2/5/24.
//

import UIKit

class TabBarRouter: NSObject {
    private var tabBarController: UITabBarController
    
    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
        super.init()
    }
}

extension TabBarRouter: Router {
    func present(_ viewControllers: [UIViewController], animated: Bool, onDismissed: (() -> Void)?) {
        tabBarController.setViewControllers(viewControllers, animated: animated)
    }
    
    func present(_ viewController: UIViewController, animated: Bool, onDismissed: (() -> Void)?) {
        //
    }
    
    func dismiss(animated: Bool) {
        //
    }
}
