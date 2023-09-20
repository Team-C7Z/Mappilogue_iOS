//
//  CustomNavigationBar.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/20.
//

import UIKit

class ImagePickerNavigationBar: BaseView {
    var onDismiss: (() -> Void)?
    var onPhotoDirectoryPickerButtonTapped: (() -> Void)?
    var onCompletion: (() -> Void)?
    
    private let dismissButton = UIButton()
    private let photoDirectoryPickerButton = PhotoDirectoryPickerButton()
    private let completionButton = UIButton()
    
    override func setupProperty() {
        super.setupProperty()

        dismissButton.setImage(UIImage(named: "common_dismiss"), for: .normal)
        completionButton.setImage(UIImage(named: "common_completion"), for: .normal)
        
        dismissButton.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
        photoDirectoryPickerButton.addTarget(self, action: #selector(photoDirectoryButtonTapped), for: .touchUpInside)
        completionButton.addTarget(self, action: #selector(completionButtonTapped), for: .touchUpInside)
    }

    override func setupHierarchy() {
        super.setupHierarchy()

        addSubview(dismissButton)
        addSubview(photoDirectoryPickerButton)
        addSubview(completionButton)
    }

    override func setupLayout() {
        super.setupLayout()
        
        self.snp.makeConstraints {
            $0.height.equalTo(44)
        }
        
        dismissButton.snp.makeConstraints {
            $0.leading.equalTo(self).offset(16)
            $0.centerY.equalTo(self).offset(-5)
            $0.width.height.equalTo(24)
        }
        
        photoDirectoryPickerButton.snp.makeConstraints {
            $0.center.equalTo(self).offset(-5)
        }
        
        completionButton.snp.makeConstraints {
            $0.trailing.equalTo(self).offset(-16)
            $0.centerY.equalTo(self).offset(-5)
            $0.width.height.equalTo(24)
        }
    }
    
    @objc func dismissButtonTapped() {
        onDismiss?()
    }
    
    @objc func photoDirectoryButtonTapped(_ button: UIButton) {
        button.isSelected = !button.isSelected
        photoDirectoryPickerButton.configure(button.isSelected)
        onPhotoDirectoryPickerButtonTapped?()
    }
    
    @objc func completionButtonTapped() {
        onCompletion?()
    }
}
