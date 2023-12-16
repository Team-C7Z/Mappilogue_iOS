//
//  TabBarCoordinator.swift
//  Mappilogue
//
//  Created by hyemi on 12/12/23.
//

import UIKit
import MappilogueKit

class TabBarCoordinator: NSObject, Coordinator, UITabBarControllerDelegate {
    var tabBarController: UITabBarController
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(tabBarController: UITabBarController, navigationController: UINavigationController) {
        self.tabBarController = tabBarController
        self.navigationController = navigationController
    }
    
    func start() {
        tabBarController.delegate = self
        
        tabBarController.view.backgroundColor = .white
        tabBarController.tabBar.backgroundColor = .grayF9F8F7
        tabBarController.tabBar.tintColor = .black1C1C1C // 선택 아이템
        tabBarController.tabBar.unselectedItemTintColor = .gray707070
        
        let homeCoordinator = HomeCoordinator(navigationController: UINavigationController())
        let calendarCoordinator = CalendarCoordinator(navigationController: UINavigationController())
        let gatheringCoordinator = GatheringCoordinator(navigationController: UINavigationController())
        let recordCoordinator = RecordCoordinator(navigationController: UINavigationController())
        let myCoordinator = MyCoordinator(navigationController: UINavigationController())
        
        homeCoordinator.navigationController.tabBarItem = UITabBarItem(title: "홈", image: Images.image(named: .tabbarHome), tag: 0)
        homeCoordinator.navigationController.isNavigationBarHidden = true
        
        calendarCoordinator.navigationController.tabBarItem = UITabBarItem(title: "캘린더", image: Images.image(named: .tabbarCalendar), tag: 1)
        calendarCoordinator.navigationController.isNavigationBarHidden = true
        
        gatheringCoordinator.navigationController.tabBarItem = UITabBarItem(title: "모임", image: Images.image(named: .tabbarGathering), tag: 2)
        
        recordCoordinator.navigationController.tabBarItem = UITabBarItem(title: "기록", image: Images.image(named: .tabbarRecord), tag: 3)
        recordCoordinator.navigationController.isNavigationBarHidden = true
        
        myCoordinator.navigationController.tabBarItem = UITabBarItem(title: "MY", image: Images.image(named: .tabbarMy), tag: 4)
        myCoordinator.navigationController.isNavigationBarHidden = true
        
        childCoordinators = [homeCoordinator, calendarCoordinator, gatheringCoordinator, recordCoordinator, myCoordinator]
        
        for coordinator in childCoordinators {
            coordinator.start()
        }
        
        tabBarController.viewControllers = [
            homeCoordinator.navigationController,
            calendarCoordinator.navigationController,
            gatheringCoordinator.navigationController,
            recordCoordinator.navigationController,
            myCoordinator.navigationController
        ]
        
        navigationController.pushViewController(tabBarController, animated: false)
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController == tabBarController.viewControllers?[2] {
            presentGatheringToastMessage(tabBarController.selectedViewController)
            return false // 이동 불가
        } else {
            return true
        }
    }
    
    private func presentGatheringToastMessage(_ viewController: UIViewController?) {
        guard let viewController = viewController else {
            return
        }
        
        var gatheringToastMessage = GatheringToastMessageView()
        
        viewController.view.addSubview(gatheringToastMessage)
        
        gatheringToastMessage.snp.makeConstraints {
            $0.bottom.equalTo(viewController.view.safeAreaLayoutGuide).offset(-2)
            $0.centerX.equalTo(viewController.view.safeAreaLayoutGuide)
        }
        
        UIView.animate(withDuration: 2, delay: 0, options: .curveLinear, animations: {
        }, completion: { (_) in
            UIView.animate(withDuration: 0.3, delay: 1, options: .curveEaseIn, animations: {
                gatheringToastMessage.alpha = 0.0
            }, completion: { (_) in
                gatheringToastMessage.removeFromSuperview()
            })
        })
    }
}
