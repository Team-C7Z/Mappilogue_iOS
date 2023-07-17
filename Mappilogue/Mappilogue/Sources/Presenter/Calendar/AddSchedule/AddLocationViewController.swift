//
//  AddLocationViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/17.
//

import UIKit

class AddLocationViewController: BaseViewController {

    private let addLocationView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        view.backgroundColor = .color404040.withAlphaComponent(0.1)
        
        addLocationView.layer.cornerRadius = 24
        addLocationView.backgroundColor = .colorF9F8F7
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(addLocationView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        addLocationView.snp.makeConstraints {
            $0.centerY.equalTo(view)
            $0.leading.equalTo(view).offset(16)
            $0.trailing.equalTo(view).offset(-16)
            $0.height.equalTo(500)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, !addLocationView.frame.contains(touch.location(in: view)) else {
            return
        }

        dismiss(animated: false)
    }
}
