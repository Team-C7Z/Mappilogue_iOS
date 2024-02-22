//
//  AlertViewController.swift
//  Mappilogue
//
//  Created by hyemi on 12/26/23.
//

import UIKit
import MappilogueKit

class AlertViewController: BaseViewController {
    public var onCancelTapped: (() -> Void)?
    public var onDoneTapped: (() -> Void)?
    
    let alertView = AlertView()
    
    override func setupProperty() {
        super.setupProperty()
        
        view.backgroundColor = .gray404040.withAlphaComponent(0.1)
        
        alertView.cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        alertView.doneButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(alertView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        alertView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    func configure(_ alert: Alert) {
        alertView.configureAlert(with: alert)
    }
    
    @objc private func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: false)
    }
    
    @objc private func deleteButtonTapped(_ sender: UIButton) {
        dismiss(animated: false) {
            self.onDoneTapped?()
        }
    }
}
