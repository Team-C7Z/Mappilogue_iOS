//
//  MapMainLocationCoordinator.swift
//  Mappilogue
//
//  Created by hyemi on 12/24/23.
//

import Foundation

protocol MapMainLocationDelegate: AnyObject {
    func popViewController()
}

class MapMainLocationCoordinator: AppCoordinator, MapMainLocationDelegate {
    override func start() {
        let mapMainLocationViewController = MapMainLocationViewController()
        mapMainLocationViewController.coordinator = self
        navigationController.pushViewController(mapMainLocationViewController, animated: false)
    }

    func popViewController() {
        navigationController.popViewController(animated: false)
    }
}
