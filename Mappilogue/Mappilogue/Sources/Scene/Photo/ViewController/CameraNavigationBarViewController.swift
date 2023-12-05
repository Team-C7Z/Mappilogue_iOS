//
//  CameraNavigationBarViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/12/05.
//

import UIKit
import MappilogueKit

class CameraNavigationBarViewController: NavigationBarViewController {
    public var onDismissButtonTapped: (() -> Void)?
    public var onSaveButtonTapped: (() -> Void)?
    
    private var navigationBar = UIView()
    private let dismissButton = UIButton()
    
    override func setupProperty() {
        super.setupProperty()

        dismissButton.setImage(Icons.icon(named: .dismiss), for: .normal)
        dismissButton.addTarget(self, action: #selector(popNavigationController), for: .touchUpInside)
    }

    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(navigationBar)
        navigationBar.addSubview(dismissButton)
    }

    override func setupLayout() {
        super.setupLayout()

        navigationBar.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
            $0.height.equalTo(88)
        }
        
        dismissButton.snp.makeConstraints {
            $0.leading.equalTo(navigationBar).offset(16)
            $0.bottom.equalTo(navigationBar).offset(-10)
            $0.width.height.equalTo(24)
        }
    }
}
