//
//  AddLocationViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/17.
//

import UIKit

class AddLocationViewController: BaseViewController {
    private let addLocationView = UIView()
    private let locationTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        view.backgroundColor = .color404040.withAlphaComponent(0.1)
        
        addLocationView.layer.cornerRadius = 24
        addLocationView.backgroundColor = .colorF9F8F7
        
        locationTextField.layer.cornerRadius = 8
        locationTextField.backgroundColor = .colorF5F3F0
        locationTextField.placeholder = "장소 검색"
        locationTextField.font = .body01
        locationTextField.addLeftPadding()
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(addLocationView)
        addLocationView.addSubview(locationTextField)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        addLocationView.snp.makeConstraints {
            $0.centerY.equalTo(view)
            $0.leading.equalTo(view).offset(16)
            $0.trailing.equalTo(view).offset(-16)
            $0.height.equalTo(500)
        }
        
        locationTextField.snp.makeConstraints {
            $0.top.equalTo(addLocationView).offset(30)
            $0.leading.equalTo(addLocationView).offset(20)
            $0.trailing.equalTo(addLocationView).offset(-20)
            $0.height.equalTo(40)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, !addLocationView.frame.contains(touch.location(in: view)) else {
            return
        }

        dismiss(animated: false)
    }
}
