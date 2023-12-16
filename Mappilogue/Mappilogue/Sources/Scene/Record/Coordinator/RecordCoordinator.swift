//
//  RecordCoordinator.swift
//  Mappilogue
//
//  Created by hyemi on 12/16/23.
//

import Foundation

protocol RecordDelegate: AnyObject {
}

class RecordCoordinator: BaseCoordinator, RecordDelegate {
    override func start() {
        let recordViewController = RecordViewController()
        navigationController.pushViewController(recordViewController, animated: false)
    }
}
