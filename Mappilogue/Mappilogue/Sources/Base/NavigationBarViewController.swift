//
//  NavigationBarViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/08.
//

import UIKit

class NavigationBarViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpRightBarButtonItem()

    }
    
    func setUpRightBarButtonItem() {
        let notificationImage = UIImage(named: "navigation_notification")
        let notificationButtonItem = UIBarButtonItem(image: notificationImage, style: .plain, target: self, action: #selector(rightBarButtonItemTapped))
        notificationButtonItem.tintColor = .color1C1C1C
        navigationItem.rightBarButtonItem = notificationButtonItem
    }
    
    @objc func rightBarButtonItemTapped() {
        print("notification")
    }
}
