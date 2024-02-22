//
//  AddLocationCoordinator.swift
//  Mappilogue
//
//  Created by hyemi on 12/29/23.
//

import UIKit

protocol AddLocationDelegate: AnyObject {
    func selectedLocation(location: KakaoSearchPlaces)
    func dismissViewController()
}

protocol ScheduleLocationDelegate: AnyObject {
    func addLocation(location: KakaoSearchPlaces)
}

class AddLocationCoordinator: AddLocationDelegate {
    weak var delegate: ScheduleLocationDelegate?
    
//    override func start() {
//        let addLocationViewController = AddLocationViewController()
//        addLocationViewController.modalPresentationStyle = .overFullScreen
//        addLocationViewController.coordinator = self
//        navigationController.present(addLocationViewController, animated: false)
//    }
//    
    func selectedLocation(location: KakaoSearchPlaces) {
        delegate?.addLocation(location: location)
        dismissViewController()
    }
    
    func dismissViewController() {
      //  childDidFinish(self)
        //  navigationController.dismiss(animated: false)
    }
}
