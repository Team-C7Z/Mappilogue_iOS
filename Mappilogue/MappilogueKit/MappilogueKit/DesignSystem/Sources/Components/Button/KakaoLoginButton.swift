//
//  KakaoLoginButton.swift
//  MappilogueKit
//
//  Created by hyemi on 2023/12/02.
//

import UIKit

public class KakaoLoginButton: UIButton {
    public init() {
        super.init(frame: .zero)
    
        setupProperty()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupProperty() {
        setImage(Images.image(named: .buttonKakaoLogin), for: .normal)
    }
    
    func setupLayout() {
        self.snp.makeConstraints {
            $0.height.equalTo(54)
        }
    }
}
