//
//  DatePickerCoordinator.swift
//  Mappilogue
//
//  Created by hyemi on 12/25/23.
//

import Foundation

protocol DatePickerDelegate: AnyObject {
    func dismissViewController()
}

class DatePickerCoordinator: BaseCoordinator, DatePickerDelegate {
    override func start() { }
    
    func showDatePickerViewController(date: SelectedDate?) {
        let datePickerViewController = DatePickerViewController()
        datePickerViewController.viewModel.selectedDate = date
        datePickerViewController.modalPresentationStyle = .overCurrentContext
        navigationController.present(datePickerViewController, animated: false)
    }
    
    func dismissViewController() {
        navigationController.dismiss(animated: false)
    }
}
