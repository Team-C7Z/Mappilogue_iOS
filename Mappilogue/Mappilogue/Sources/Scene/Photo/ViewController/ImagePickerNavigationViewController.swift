//
//  ImagePickerNavigationViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/20.
//

import UIKit

class ImagePickerNavigationViewController: NavigationBarViewController {
    var onPhotoDirectoryPickerButtonTapped: (() -> Void)?
    
    var isButton: Bool = true
    
    let photoDirectoryPickerButton = PhotoDirectoryPickerButton()
    
    override func setupProperty() {
        super.setupProperty()

        setDismissSaveBar(title: "")
        
        dismissSaveBar.onDismissButtonTapped = {
            self.navigationController?.popViewController(animated: false)
        }
    }

    override func setupHierarchy() {
        super.setupHierarchy()

        dismissSaveBar.addSubview(photoDirectoryPickerButton)
    }

    override func setupLayout() {
        super.setupLayout()

        photoDirectoryPickerButton.snp.makeConstraints {
            $0.centerX.equalTo(dismissSaveBar)
            $0.bottom.equalTo(dismissSaveBar).offset(0)
        }
    }
    
    func photoDirectoryButtonTapped() {
        isButton = !isButton
        photoDirectoryPickerButton.configure(isButton)
        onPhotoDirectoryPickerButtonTapped?()
    }
}
