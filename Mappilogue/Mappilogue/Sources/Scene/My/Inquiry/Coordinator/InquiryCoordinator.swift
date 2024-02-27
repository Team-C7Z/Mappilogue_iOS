//
//  InquiryCoordinator.swift
//  Mappilogue
//
//  Created by hyemi on 12/18/23.
//

import Foundation

protocol InquiryDelegate: AnyObject {
    func popViewController()
}

class InquiryCoordinator: BaseCoordinator {
    override func start() {
        let inquiryViewController = InquiryViewController()
        inquiryViewController.hidesBottomBarWhenPushed = true
        inquiryViewController.coordinator = self
        navigationController.pushViewController(inquiryViewController, animated: false)
    }
    
    func popViewController() {
        childDidFinish(self)
        navigationController.popViewController(animated: false)
    }
}
