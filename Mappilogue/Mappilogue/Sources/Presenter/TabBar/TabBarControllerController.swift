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
        tabBar.tintColor = .color1C1C1C // 선택 아이템
        tabBar.unselectedItemTintColor = .color707070
        
        setTabBar()
    }
    
    func setTabBar() {
        let viewControllers = [
            createViewController(HomeViewController(), title: "홈", imageName: "home"),
            createViewController(CalendarViewController(), title: "캘린더", imageName: "calendar"),
            createViewController(GatheringViewController(), title: "모임", imageName: "gathering"),
            createViewController(RecordViewController(), title: "기록", imageName: "record"),
            createViewController(MyViewController(), title: "MY", imageName: "my")
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
