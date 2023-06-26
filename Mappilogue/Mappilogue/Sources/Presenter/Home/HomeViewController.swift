//
//  HomeViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/05/17.
//

import UIKit

class HomeViewController: NavigationBarViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
    }
    
    func setNavigationBar() {
        title = ""
        
        let logoImage = UIImage(named: "home_logo")?.withRenderingMode(.alwaysOriginal)
        let buttonItem = UIBarButtonItem(image: logoImage, style: .plain, target: self, action: nil)
        navigationItem.leftBarButtonItem = buttonItem
    }
}
