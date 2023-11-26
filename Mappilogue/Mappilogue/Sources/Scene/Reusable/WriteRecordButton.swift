//
//  WriteRecordButton.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/24.
//

import UIKit

class WriteRecordButton: UIButton {
    init() {
        super.init(frame: .zero)
        
        layer.applyMainColorShadow()
        setImage(UIImage(named: "writeRecord"), for: .normal)
        
        self.snp.makeConstraints {
            $0.width.height.equalTo(56)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
