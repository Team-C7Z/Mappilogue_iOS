//
//  MyRecordButton.swift
//  MappilogueKit
//
//  Created by hyemi on 2023/12/04.
//

import UIKit

public class MyRecordButton: UIButton {
    public init() {
        super.init(frame: .zero)
        
        setMyRecordButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setMyRecordButton() {
        layer.applyMainColorShadow()
        setImage(Images.image(named: .buttonMyRecord), for: .normal)
    
        self.snp.makeConstraints {
            $0.width.height.equalTo(56)
        }
    }
}
