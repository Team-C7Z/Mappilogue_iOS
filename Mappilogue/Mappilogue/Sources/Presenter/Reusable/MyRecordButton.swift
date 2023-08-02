//
//  MyRecordButton.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/29.
//

import UIKit

class MyRecordButton: UIButton {
    init() {
        super.init(frame: .zero)
        
        layer.applyMainColorShadow()
        setImage(UIImage(named: "recordList"), for: .normal)
    
        self.snp.makeConstraints {
            $0.width.height.equalTo(56)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
