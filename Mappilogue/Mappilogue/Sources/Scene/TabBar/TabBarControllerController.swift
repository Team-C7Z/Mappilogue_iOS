//
//  TabBarController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/05/17.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    var gatheringToastMessage = GatheringToastMessageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        tabBar.backgroundColor = .grayF9F8F7
        tabBar.tintColor = .black1C1C1C // 선택 아이템
        tabBar.unselectedItemTintColor = .gray707070
        
        setTabBar()
        
        self.delegate = self
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
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController == self.viewControllers?[2] {
            presentGatheringToastMessage()
            return false // 이동 불가
        } else {
            return true
        }
    }
    
    func setGatheringToastMessage() {
        view.addSubview(gatheringToastMessage)
        
        gatheringToastMessage.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-52)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func presentGatheringToastMessage() {
        self.setGatheringToastMessage()
        
        UIView.animate(withDuration: 2, delay: 0, options: .curveLinear, animations: {
            
        }, completion: { (_) in
            UIView.animate(withDuration: 0.3, delay: 1, options: .curveEaseIn, animations: {
                self.gatheringToastMessage.alpha = 0.0
            }, completion: { (_) in
                self.gatheringToastMessage.alpha = 1.0
                self.gatheringToastMessage.removeFromSuperview()
                
            })
        })
    }
}
