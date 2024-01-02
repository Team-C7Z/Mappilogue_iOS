//
//  EditBottomSheetCoordinator.swift
//  Mappilogue
//
//  Created by hyemi on 1/2/24.
//

import MappilogueKit

protocol EditBottomSheetDelegate: AnyObject {
   
}

class EditBottomSheetCoordinator: AppCoordinator, EditBottomSheetDelegate {
    override func start() { }
    
    func showEditBottomSheetViewController(modifyTitle: String, deleteTitle: String, alert: Alert) {
        let editViewController = EditBottomSheetViewController()
        editViewController.modalPresentationStyle = .overFullScreen
        editViewController.coordinator = self
        editViewController.configure(modifyTitle: "수정하기",
                                             deleteTitle: "삭제하기",
                                             alert: Alert(titleText: "이 기록을 삭제할까요?",
                                                          messageText: nil,
                                                          cancelText: "취소",
                                                          doneText: "삭제",
                                                          buttonColor: .redF14C4C,
                                                          alertHeight: 140)
        )
        navigationController.present(editViewController, animated: false)
    }

    func showAlertViewController(alert: Alert) {
        let coordinator = AlertCoordinator(navigationController: self.navigationController)
        coordinator.showAlert(alert)
        childCoordinators.append(coordinator)
    }
    
    func dismissViewController() {
        navigationController.dismiss(animated: false) 
    }
}
