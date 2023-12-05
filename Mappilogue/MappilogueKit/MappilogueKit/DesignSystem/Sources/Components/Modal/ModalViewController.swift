//
//  ModalViewController.swift
//  MappilogueKit
//
//  Created by hyemi on 2023/12/04.
//

import UIKit

open class ModalViewController: UIViewController {
    public let modalView = UIView()
    
    override open func viewDidLoad() {
        super.viewDidLoad()

        setupProperty()
        setupHierarchy()
        setupLayout()
    }
    
    func setupProperty() {
        view.backgroundColor = .gray404040.withAlphaComponent(0.1)
        
        modalView.layer.cornerRadius = 24
        modalView.backgroundColor = .grayF9F8F7
    }
    
    func setupHierarchy() {
        view.addSubview(modalView)
    }
    
    func setupLayout() {
        modalView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(429)
        }
    }
}
