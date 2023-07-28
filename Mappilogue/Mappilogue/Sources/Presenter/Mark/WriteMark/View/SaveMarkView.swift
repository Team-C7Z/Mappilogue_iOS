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
    let saveMarkButton = UIButton()
    let hideKeyboardButton = UIButton()
    
    override func setupProperty() {
        super.setupProperty()
        
        backgroundColor = .colorF9F8F7
        lineView.backgroundColor = .colorEAE6E1
        cameraButton.setImage(UIImage(named: "camera"), for: .normal)
        
        saveMarkButton.setTitle("기록 저장", for: .normal)
        saveMarkButton.setTitleColor(.colorFFFFFF, for: .normal)
        saveMarkButton.titleLabel?.font = .body03
        saveMarkButton.layer.cornerRadius = 35 / 2
        saveMarkButton.backgroundColor = .color2EBD3D
        
        hideKeyboardButton.setImage(UIImage(named: "hideKeyboard"), for: .normal)
        hideKeyboardButton.isHidden = true
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()

        addSubview(lineView)
        addSubview(cameraButton)
        addSubview(saveMarkButton)
        addSubview(hideKeyboardButton)
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
        
        hideKeyboardButton.snp.makeConstraints {
            $0.top.equalTo(self).offset(4)
            $0.trailing.equalTo(self).offset(-7)
            $0.width.height.equalTo(40)
        }
    }
    
    func configure(_ showKeyboard: Bool) {
        if !showKeyboard {
            hideKeyboardButton.isHidden = true
            saveMarkButton.isHidden = false
        } else {
            hideKeyboardButton.isHidden = false
            saveMarkButton.isHidden = true
        }
    }
}
