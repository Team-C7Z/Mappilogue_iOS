//
//  CalendarCoordinator.swift
//  Mappilogue
//
//  Created by hyemi on 12/16/23.
//

import Foundation

protocol CalendarDelegate: AnyObject {
}

class CalendarCoordinator: BaseCoordinator, CalendarDelegate {
    override func start() {
        let calendarViewController = CalendarViewController()
        navigationController.pushViewController(calendarViewController, animated: false)
    }
}
