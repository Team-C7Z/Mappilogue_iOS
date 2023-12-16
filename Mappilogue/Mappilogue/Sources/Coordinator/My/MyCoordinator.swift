//
//  MyCoordinator.swift
//  Mappilogue
//
//  Created by hyemi on 12/16/23.
//

import Foundation

protocol MyDelegate: AnyObject {
}

class MyCoordinator: BaseCoordinator, MyDelegate {
    override func start() {
        let myViewController = MyViewController()
        navigationController.pushViewController(myViewController, animated: false)
    }
}
