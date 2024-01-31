//
//  DatePickerCoordinator.swift
//  Mappilogue
//
//  Created by hyemi on 12/25/23.
//

import Foundation

protocol DatePickerDelegate: AnyObject {
    func dismissViewController(date: SelectedDate)
}

protocol DismissDatePickerDelegate: AnyObject {
    func changedDate(_ date: SelectedDate)
}

class DatePickerCoordinator: BaseCoordinator, DatePickerDelegate {
    weak var delegate: DismissDatePickerDelegate?
    
    override func start() { }
    
    func showDatePickerViewController(date: SelectedDate?) {
        let datePickerViewController = DatePickerViewController()
        datePickerViewController.coordinator = self
        datePickerViewController.viewModel.selectedDate = date
        datePickerViewController.modalPresentationStyle = .overCurrentContext
        navigationController.present(datePickerViewController, animated: false)
    }
    
    func dismissViewController(date: SelectedDate) {
        delegate?.changedDate(date)
        childDidFinish(self)
        navigationController.dismiss(animated: false)
    }
}
