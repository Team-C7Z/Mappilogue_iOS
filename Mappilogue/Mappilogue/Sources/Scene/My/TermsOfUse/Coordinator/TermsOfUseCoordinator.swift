//
//  TermsOfUseCoordinator.swift
//  Mappilogue
//
//  Created by hyemi on 12/18/23.
//

import Foundation

protocol TermsOfUseDelegate: AnyObject {
    func popViewController()
}

class TermsOfUseCoordinator: BaseCoordinator, TermsOfUseDelegate {
    override func start() {
        let termsOfUseViewController = TermsOfUseViewController()
        termsOfUseViewController.hidesBottomBarWhenPushed = true
        termsOfUseViewController.coordinator = self
        navigationController.pushViewController(termsOfUseViewController, animated: false)
    }
    
    func popViewController() {
        childDidFinish(self)
        navigationController.popViewController(animated: false)
    }
}
