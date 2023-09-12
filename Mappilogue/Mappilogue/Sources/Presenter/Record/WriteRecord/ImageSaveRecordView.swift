//
//  ImageSaveRecordView.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/27.
//

import UIKit

class ImageSaveRecordView: BaseView {
    private let lineView = UIView()
    let addImageButton = UIButton()
    let addImageImage = UIImageView()
    let saveRecordButton = UIButton()
    let hideKeyboardButton = UIButton()
    
    override func setupProperty() {
        super.setupProperty()
        
        backgroundColor = .colorF9F8F7
        
        lineView.backgroundColor = .colorEAE6E1
        
        addImageImage.image = UIImage(named: "record_addImage")
        addImageImage.contentMode = .scaleAspectFit
        
        saveRecordButton.setTitle("기록 저장", for: .normal)
        saveRecordButton.setTitleColor(.colorFFFFFF, for: .normal)
        saveRecordButton.titleLabel?.font = .body03
        saveRecordButton.layer.cornerRadius = 35 / 2
        saveRecordButton.backgroundColor = .color2EBD3D
        
        hideKeyboardButton.setImage(UIImage(named: "hideKeyboard"), for: .normal)
        hideKeyboardButton.isHidden = true
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()

        addSubview(lineView)
        addSubview(addImageButton)
        addImageButton.addSubview(addImageImage)
        addSubview(saveRecordButton)
        addSubview(hideKeyboardButton)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        lineView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(self)
            $0.height.equalTo(2)
        }
        
        addImageButton.snp.makeConstraints {
            $0.top.equalTo(self).offset(8)
            $0.leading.equalTo(self).offset(16)
            $0.width.height.equalTo(32)
        }
        
        addImageImage.snp.makeConstraints {
            $0.center.equalTo(addImageButton)
            $0.width.equalTo(32)
            $0.height.equalTo(24)
        }
        
        saveRecordButton.snp.makeConstraints {
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
        hideKeyboardButton.isHidden = showKeyboard ? false : true
        saveRecordButton.isHidden = showKeyboard ? true : false
    }   
}
