//
//  TabBarController.swift
//  Mappilogue
//
//  Created by hyemi on 2/16/24.
//

import UIKit
import MappilogueKit

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
            createViewController(HomeViewController(), title: "홈", image: Images.image(named: .tabbarHome)),
            createViewController(CalendarViewController(), title: "캘린더", image: Images.image(named: .tabbarCalendar)),
            createViewController(GatheringViewController(), title: "모임", image: Images.image(named: .tabbarGathering)),
            createViewController(RecordViewController(), title: "기록", image: Images.image(named: .tabbarRecord)),
            createViewController(MyViewController(), title: "MY", image: Images.image(named: .tabbarMy))
        ]

        setViewControllers(viewControllers, animated: false)
    }
    
    func createViewController(_ viewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.isNavigationBarHidden = true
        viewController.title = title
        viewController.tabBarItem.image = image
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