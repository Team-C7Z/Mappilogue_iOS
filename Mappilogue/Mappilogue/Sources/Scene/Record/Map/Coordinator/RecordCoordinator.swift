//
//  RecordCoordinator.swift
//  Mappilogue
//
//  Created by hyemi on 12/16/23.
//

import MappilogueKit

// protocol RecordDelegate: AnyObject {
//    func showNotificationController()
//    func showSearchViewController()
//    func showCategorySettingViewController()
//    func showMyRecordListViewController()
//    func showWriteRecordViewController()
// }

class RecordCoordinator: RecordViewControllerDelegate {
 //   public var children: [Coordinator1] = []
    public let router: Router
    
    public init(router: Router) {
        self.router = router
    }
    
    func present(animated: Bool, onDismissed: (() -> Void)?) {
//        let viewController = RecordViewController(delegate: self)
//        router.present(viewController, animated: animated, onDismissed: onDismissed)
    }
//
//    override func start() {
////        let recordViewController = RecordViewController()
////        recordViewController.coordinator = self
////        navigationController.pushViewController(recordViewController, animated: false)
//    }
//    
//    func showNotificationController() {
//        let coordinator = NotificationCoordinator(navigationController: self.navigationController)
//        coordinator.start()
//        self.childCoordinators.append(coordinator)
//    }
//    
//    func showSearchViewController() {
//        let coordinator = SearchCoordinator(navigationController: self.navigationController)
//        coordinator.start()
//        self.childCoordinators.append(coordinator)
//    }
//    
//    func showCategorySettingViewController() {
//        let coordinator = CategorySettingCoordinator(navigationController: self.navigationController)
//        coordinator.start()
//        self.childCoordinators.append(coordinator)
//    }
//    
//    func showMyRecordListViewController() {
//        let coordinator = MyRecordListCoordinator(navigationController: self.navigationController)
//        coordinator.start()
//        self.childCoordinators.append(coordinator)
//    }
//    
//    func showWriteRecordViewController() {
//        let coordinator = WriteRecordListCoordinator(navigationController: self.navigationController)
//        coordinator.start()
//        self.childCoordinators.append(coordinator)
//    }
//    
//    func showAlertViewController(alert: Alert) {
//        let coordinator = AlertCoordinator(navigationController: self.navigationController)
//        coordinator.showAlert(alert)
//        self.childCoordinators.append(coordinator)
//    }
    
}
