//
//  InputModalCoorinator.swift
//  Mappilogue
//
//  Created by hyemi on 12/30/23.
//
import Foundation

protocol InputModalDelegate: AnyObject {
   func dismissViewController()
}

protocol ModalCompletionDelegate: AnyObject {
    func completeModalAction(_ text: String)
}

class InputModalCoordinator: AppCoordinator, InputModalDelegate {
    weak var delegate: ModalCompletionDelegate?
    
    override func start() { }
    
    func showInputModalViewController(categoryName: String) {
        let inputModalViewController = InputModalViewController()
        inputModalViewController.modalPresentationStyle = .overCurrentContext
        inputModalViewController.coordinator = self
        inputModalViewController.configure(categoryName)
        inputModalViewController.onCompletionTapped = { text in
            self.delegate?.completeModalAction(text)
        }
        navigationController.present(inputModalViewController, animated: false)
    }
    
    func dismissViewController() {
        navigationController.dismiss(animated: false)
    }
}
