//
//  TabBarController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/05/17.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setTabBar()
    }
    
    func setTabBar() {
        let viewControllers = [
            createViewController(HomeViewController(), title: "홈", imageName: "home"),
            createViewController(HomeViewController(), title: "캘린더", imageName: "calendar"),
            createViewController(HomeViewController(), title: "모임", imageName: "gathering"),
            createViewController(HomeViewController(), title: "기록", imageName: "record"),
            createViewController(HomeViewController(), title: "My", imageName: "my")
        ]

        setViewControllers(viewControllers, animated: false)
    }
    
    func createViewController(_ viewController: UIViewController, title: String, imageName: String) -> UIViewController {
        let navigationController = UINavigationController(rootViewController: viewController)
        viewController.title = title
        viewController.tabBarItem.image = UIImage(named: imageName)
        return navigationController
    }
}
