//
//  SaveMarkView.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/27.
//

import UIKit

class SaveMarkView: BaseView {
    private let lineView = UIView()
    private let cameraButton = UIButton()
    private let saveMarkButton = UIButton()
    
    override func setupProperty() {
        super.setupProperty()
        
        lineView.backgroundColor = .colorEAE6E1
        
        cameraButton.setImage(UIImage(named: "camera"), for: .normal)
        
        saveMarkButton.setTitle("기록 저장", for: .normal)
        saveMarkButton.setTitleColor(.colorFFFFFF, for: .normal)
        saveMarkButton.titleLabel?.font = .body03
        saveMarkButton.layer.cornerRadius = 35 / 2
        saveMarkButton.backgroundColor = .color2EBD3D
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()

        addSubview(lineView)
        addSubview(cameraButton)
        addSubview(saveMarkButton)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        lineView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(self)
            $0.height.equalTo(2)
        }
        
        cameraButton.snp.makeConstraints {
            $0.top.equalTo(self).offset(4)
            $0.leading.equalTo(self).offset(6)
            $0.width.equalTo(48)
            $0.height.equalTo(40)
        }
        
        saveMarkButton.snp.makeConstraints {
            $0.trailing.equalTo(-16)
            $0.top.equalTo(7)
            $0.width.equalTo(70)
            $0.height.equalTo(35)
        }
    }
}
