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

class SearchCoordinator: AppCoordinator, SearchDelegate {
    override func start() {
        let searchViewController = SearchViewController()
        searchViewController.hidesBottomBarWhenPushed = true
        searchViewController.coordinator = self
        navigationController.pushViewController(searchViewController, animated: false)
    }
    
    func popViewController() {
        navigationController.popViewController(animated: false)
    }
}
