//
//  ImageDetailViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/12/06.
//

import UIKit
import MappilogueKit

class ImageDetailViewController: BaseViewController {
    private var outerView = UIView()
    private var image = UIImageView()
    private var dismissButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func setupProperty() {
        super.setupProperty()
        
        view.backgroundColor = .gray404040.withAlphaComponent(0.7)
        
        image.contentMode = .scaleAspectFit
        dismissButton.setImage(Images.image(named: .buttonDismissImage), for: .normal)
        dismissButton.addTarget(self, action: #selector(dismissImageDetailViewController), for: .touchUpInside)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(outerView)
        outerView.addSubview(image)
        outerView.addSubview(dismissButton)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        outerView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo((view.frame.width * (4 / 3)) + 19 + 42)
        }

        image.snp.makeConstraints {
            $0.leading.top.trailing.equalTo(outerView)
            $0.height.equalTo(view.frame.width * (4 / 3))
        }
        
        dismissButton.snp.makeConstraints {
            $0.centerX.bottom.equalTo(outerView)
            $0.width.height.equalTo(42)
        }
    }
    
    func configure(_ imageName: String) {
        self.image.image = UIImage(named: imageName)
    }
    
    @objc func dismissImageDetailViewController() {
        dismiss(animated: false)
    }
}
