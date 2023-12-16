//
//  ContentCoordinator.swift
//  Mappilogue
//
//  Created by hyemi on 12/17/23.
//

import Foundation

protocol ContentDelegate: AnyObject {
}

class ContentCoordinator: BaseCoordinator, ContentDelegate {
    override func start() {
        let contentViewController = ContentViewController()
        contentViewController.hidesBottomBarWhenPushed = true
        contentViewController.coordinator = self
        navigationController.pushViewController(contentViewController, animated: false)
    }
}
