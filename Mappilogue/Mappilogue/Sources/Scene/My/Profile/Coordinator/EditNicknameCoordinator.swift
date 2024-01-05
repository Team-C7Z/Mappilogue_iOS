//
//  EditNicknameCoordinator.swift
//  Mappilogue
//
//  Created by hyemi on 12/17/23.
//

import Foundation

protocol EditNicknameDelegate: AnyObject {
    func showEditNicknameModalViewController(_ nickname: String?)
    func dismissViewController(_ nickname: String)
}

protocol NicknameDelegate: AnyObject {
    func changedNickname(nickname: String)
}

class EditNicknameCoordinator: BaseCoordinator, EditNicknameDelegate {
    weak var delegate: NicknameDelegate?
    
    override func start() {
        
    }
    
    func showEditNicknameModalViewController(_ nickname: String?) {
        let editNicknameModalViewController = EditNicknameModalViewController()
        editNicknameModalViewController.modalPresentationStyle = .overCurrentContext
        editNicknameModalViewController.coordinator = self
        editNicknameModalViewController.configure(nickname ?? "")
        navigationController.present(editNicknameModalViewController, animated: false)
    }

    func dismissViewController(_ nickname: String) {
        delegate?.changedNickname(nickname: nickname)
        childDidFinish(self)
        navigationController.dismiss(animated: false)
    }
}
