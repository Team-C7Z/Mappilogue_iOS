//
//  EditBottomSheetViewController.swift
//  Mappilogue
//
//  Created by hyemi on 12/26/23.
//

import UIKit
import MappilogueKit

class EditBottomSheetViewController: UIViewController {
    weak var coordinator: EditBottomSheetCoordinator?
    var alert: Alert?
    public var onModify: (() -> Void)?
    public var onDelete: (() -> Void)?
    
    var modalView = EditBottomSheetView()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        setupProperty()
        setupHierarchy()
        setupLayout()
    }
    
   func setupProperty() {
        view.backgroundColor = .gray404040.withAlphaComponent(0.1)
        
       modalView.modifyButton.addTarget(self, action: #selector(modifyButtonTapped), for: .touchUpInside)
        
       modalView.deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }
    
    func setupHierarchy() {
        view.addSubview(modalView)
    }
    
    func setupLayout() {
        modalView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalTo(view)
        }

    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, touch.location(in: view).y < modalView.frame.maxY else {
            return
        }
        coordinator?.dismissViewController()
    }
    
    public func configure(modifyTitle: String, deleteTitle: String, alert: Alert) {
        self.alert = alert
        
        modalView.configure(modifyTitle: modifyTitle, deleteTitle: deleteTitle, alert: alert)
    }
    
    @objc func modifyButtonTapped(_ button: UIButton) {
        onModify?()
        coordinator?.dismissViewController()
    }
    
    @objc func deleteButtonTapped(_ button: UIButton) {
        guard let alert = alert else { return }

        coordinator?.dismissViewController()
        coordinator?.showAlertViewController(alert: alert)
    }
}
