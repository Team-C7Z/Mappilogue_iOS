//
//  NavigationBarViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/12/03.
//

import UIKit
import MappilogueKit

class NavigationBarViewController: BaseViewController {
    let logoNotoficationBar = LogoNotificationBar()
    let popBar = PopBar()
    let popNotificationBar = PopNotificationBar()
    let dismissSaveBar = DismissSaveBar()
    let notificationBar = NotificationBar()
    let popMenuBar = PopMenuBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupProperty() {
        super.setupProperty()
        
    }
    
    func setLogoNotificationBar() {
//        logoNotoficationBar.onNotificationButtonTapped = {
//            self.pushNotificationController()
//        }

        view.addSubview(logoNotoficationBar)
        
        logoNotoficationBar.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
        }
    }
    
    func setPopNotificationBar(title: String) {
        popNotificationBar.configure(title: title)
        
        view.addSubview(popNotificationBar)
        
        popNotificationBar.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
        }
    }
    
    func setPopBar(title: String) {
        setDefaultPopBar(title: title)
    }
    
    func setDefaultPopBar(title: String) {
        popBar.configure(title: title)
        
        view.addSubview(popBar)
        
        popBar.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
        }
    }
    
    func setDismissSaveBar(title: String) {
        dismissSaveBar.configure(title: title)
        view.addSubview(dismissSaveBar)
        
        dismissSaveBar.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
        }
    }
    
    func setNotificationBar(title: String) {
        notificationBar.configure(title: title)
        
        notificationBar.onNotificationButtonTapped = {
            self.pushNotificationController()
        }
        
        view.addSubview(notificationBar)
        
        notificationBar.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
        }
    }
    
    func setPopMenuBar(title: String) {
        popMenuBar.configure(title: title)
        
        popMenuBar.onPopButtonTapped = {
            self.popNavigationController()
        }
        
        view.addSubview(popMenuBar)
        
        popMenuBar.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
        }
    }
    
    func pushNotificationController() {
//        let notificationController = NotificationViewController()
//        notificationController.hidesBottomBarWhenPushed = true
//        navigationController?.pushViewController(notificationController, animated: true)
    }
    
    @objc func popNavigationController() {
        navigationController?.popViewController(animated: true)
    }
}
