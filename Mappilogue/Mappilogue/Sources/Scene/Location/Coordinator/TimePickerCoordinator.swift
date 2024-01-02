//
//  TimePickerCoordinator.swift
//  Mappilogue
//
//  Created by hyemi on 12/29/23.
//

import Foundation

protocol TimePickerDelegate: AnyObject {
    func dismissViewController()
}

class TimePickerCoordinator: AppCoordinator, TimePickerDelegate {
    override func start() { }
    
    func showTimePickerViewController(_ selectedTime: String) {
        let timePickerViewController = TimePickerViewController()
        timePickerViewController.modalPresentationStyle = .overFullScreen
        timePickerViewController.selectedTime = selectedTime
        navigationController.present(timePickerViewController, animated: false)
    }
    
    func dismissViewController() {
        navigationController.dismiss(animated: false)
    }
}
