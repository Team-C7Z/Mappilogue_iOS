//
//  NavigationBarViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/12/03.
//

import UIKit
import MappilogueKit

class NavigationBarViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupProperty() {
        super.setupProperty()
        
    }
    
    func setLogoNotificationBar() {
        let logoNotoficationBar = LogoNotificationBar()
        
        logoNotoficationBar.onNotificationButtonTapped = {
            self.notificationButtonTapped()
        }

        view.addSubview(logoNotoficationBar)
        
        logoNotoficationBar.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
        }
    }
    
    func setPopNotificationBar(title: String) {
        let popNotificationBar = PopNotificationBar(title: title)
        
        view.addSubview(popNotificationBar)
        
        popNotificationBar.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
        }
    }
    
    func setPopBarBar(title: String) {
        let popBar = PopBar(title: title)

        popBar.onPopButtonTapped = {
            self.popButtonTapped()
        }
        
        view.addSubview(popBar)
        
        popBar.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
        }
    }
    
    func setDismissSaveBarBar(title: String) {
        let dismissSaveBar = DismissSaveBar(title: title)
        
        view.addSubview(dismissSaveBar)
        
        dismissSaveBar.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
        }
    }
    
    func setNotificationBar(title: String) {
        let notificationBar = NotificationBar(title: title)

        view.addSubview(notificationBar)
        
        notificationBar.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
        }
    }
    
    func setPopMenuBar(title: String) {
        let popMenuBar = PopMenuBar(title: title)
        view.addSubview(popMenuBar)
        
        popMenuBar.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
        }
    }
    
    func notificationButtonTapped() {
        let notificationController = NotificationController()
        notificationController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(notificationController, animated: true)
    }
    
    func popButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
