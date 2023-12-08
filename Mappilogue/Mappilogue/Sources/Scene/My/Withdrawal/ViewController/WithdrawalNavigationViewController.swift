//
//  WithdrawalNavigationViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/12/03.
//

import UIKit

class WithdrawalNavigationViewController: NavigationBarViewController {
    let skipButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setupProperty() {
        setPopBar(title: "탈퇴하기")
        
        skipButton.setTitle("건너뛰기", for: .normal)
        skipButton.setTitleColor(.gray9B9791, for: .normal)
        skipButton.titleLabel?.font = .body02
        
    }
    
    override func setupHierarchy() {
        popBar.addSubview(skipButton)
    }
    
    override func setupLayout() {
        skipButton.snp.makeConstraints {
            $0.bottom.equalTo(popBar).offset(-11)
            $0.trailing.equalTo(popBar).offset(-14)
        }
    }
}
