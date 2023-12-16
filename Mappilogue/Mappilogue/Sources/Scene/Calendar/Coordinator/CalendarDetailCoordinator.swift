//
//  CalendarDetailCoordinator.swift
//  Mappilogue
//
//  Created by hyemi on 12/16/23.
//

import Foundation

protocol CalendarDetailDelegate: AnyObject {
}

class CalendarDetailCoordinator: BaseCoordinator, CalendarDetailDelegate {
    override func start() {
        let calendarDetailViewController = CalendarDetailViewController()
        calendarDetailViewController.coordinator = self
        navigationController.pushViewController(calendarDetailViewController, animated: false)
    }
}
