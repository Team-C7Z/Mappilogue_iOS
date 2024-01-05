//
//  MapMainLocationCoordinator.swift
//  Mappilogue
//
//  Created by hyemi on 12/24/23.
//

import MappilogueKit

protocol MapMainLocationDelegate: AnyObject {
    func showLocationPermissionAlert(alert: Alert)
    func popViewController()
}

class MapMainLocationCoordinator: AppCoordinator, MapMainLocationDelegate {
    override func start() {
        let mapMainLocationViewController = MapMainLocationViewController()
        mapMainLocationViewController.coordinator = self
        navigationController.pushViewController(mapMainLocationViewController, animated: false)
    }
    
    func showLocationPermissionAlert(alert: Alert) {
        let coordinator = AlertCoordinator(navigationController: self.navigationController)
        coordinator.showAlert(alert)
        self.childCoordinators.append(coordinator)
    }

    func popViewController() {
        childDidFinish(self)
        navigationController.popViewController(animated: false)
    }
}
