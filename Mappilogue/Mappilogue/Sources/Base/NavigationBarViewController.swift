//
//  NavigationBarViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/08.
//

import UIKit

class NavigationBarViewController: BaseViewController {
    
    private let notificationButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpRightBarButtonItem()

    }
    
    func setUpRightBarButtonItem() {
        let notificationImage = UIImage(named: "notification")
        let notificationButtonItem = UIBarButtonItem(image: notificationImage, style: .plain, target: self, action: #selector(rightBarButtonItemTapped))
        notificationButtonItem.tintColor = .color1C1C1C
        navigationItem.rightBarButtonItem = notificationButtonItem
    }
    
    @objc func rightBarButtonItemTapped() {
        let notificationController = NotificationController()
        notificationController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(notificationController, animated: true)
    }
}
