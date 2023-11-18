//
//  LimitedPhotoSelectionView.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/20.
//

import UIKit

class LimitedPhotoSelectionView: BaseView {
    let addImagesButton = UIButton()
    private let addImagesLabel = UILabel()
    let setPermissionButton = UIButton()
    private let setPermissionLabel = UILabel()
    private let setPermissionSubLabel = UILabel()
    
    override func setupProperty() {
        super.setupProperty()
        
        addImagesLabel.text = "더 많은 사진 선택하기"
        addImagesLabel.textColor = .color1C1C1C
        addImagesLabel.font = .body02
        
        setPermissionLabel.text = "접근 권한 설정으로 이동하기"
        setPermissionLabel.textColor = .color1C1C1C
        setPermissionLabel.font = .body02
        
        setPermissionSubLabel.text = "모든 사진에 접근할 수 있게 변경해 보세요"
        setPermissionSubLabel.textColor = .colorC9C6C2
        setPermissionSubLabel.font = .caption01
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(addImagesButton)
        addImagesButton.addSubview(addImagesLabel)
        addSubview(setPermissionButton)
        setPermissionButton.addSubview(setPermissionLabel)
        setPermissionButton.addSubview(setPermissionSubLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        addImagesButton.snp.makeConstraints {
            $0.leading.top.trailing.equalTo(self)
            $0.height.equalTo(54)
        }
        
        addImagesLabel.snp.makeConstraints {
            $0.leading.equalTo(addImagesButton).offset(16)
            $0.centerY.equalTo(addImagesButton)
        }
        
        setPermissionButton.snp.makeConstraints {
            $0.top.equalTo(addImagesButton.snp.bottom)
            $0.leading.trailing.equalTo(self)
            $0.height.equalTo(54)
        }
        
        setPermissionLabel.snp.makeConstraints {
            $0.top.equalTo(setPermissionButton).offset(8)
            $0.leading.equalTo(setPermissionButton).offset(16)
        }
        
        setPermissionSubLabel.snp.makeConstraints {
            $0.top.equalTo(setPermissionButton).offset(30)
            $0.leading.equalTo(setPermissionButton).offset(16)
        }
    }
}
