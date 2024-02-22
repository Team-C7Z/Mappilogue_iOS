//
//  SearchCoordinator.swift
//  Mappilogue
//
//  Created by hyemi on 12/24/23.
//

import Foundation

protocol SearchDelegate: AnyObject {
    func popViewController()
}

class SearchCoordinator: SearchDelegate {
   func start() {
        let searchViewController = SearchViewController()
        searchViewController.hidesBottomBarWhenPushed = true
        searchViewController.coordinator = self
     //   navigationController.pushViewController(searchViewController, animated: false)
    }
    
    func popViewController() {
    //    childDidFinish(self)
    //    navigationController.popViewController(animated: false)
    }
}
