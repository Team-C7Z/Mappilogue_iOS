//
//  MyRecordCoordinator.swift
//  Mappilogue
//
//  Created by hyemi on 12/24/23.
//

import Foundation

protocol MyRecordDelegate: AnyObject {
    func popViewController()
}

class MyRecordCoordinator: AppCoordinator, MyRecordDelegate {
    override func start() { }
    
    func showMyRecordViewController(categoryId: Int, categoryName: String) {
        let myRecordViewController = MyRecordViewController()
        myRecordViewController.categoryId = categoryId
        myRecordViewController.categoryName = categoryName
        myRecordViewController.coordinator = self
        navigationController.pushViewController(myRecordViewController, animated: false)
    }
    
    func popViewController() {
        navigationController.popViewController(animated: false)
    }
}
