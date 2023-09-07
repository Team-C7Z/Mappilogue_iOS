//
//  CaptureImageViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/09/09.
//

import UIKit

class CaptureImageViewController: BaseViewController {
    private let captureImage = UIImageView()
    
    override func setupProperty() {
        super.setupProperty()
    
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(captureImage)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        captureImage.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-78)
        }
    }
    
    func configure(_ image: UIImage) {
        captureImage.image = image
    }
}
