//
//  WriteMarkButton.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/24.
//

import UIKit

class WriteMarkButton: UIButton {
    init() {
        super.init(frame: .zero)
        
        setImage(UIImage(named: "writeMark"), for: .normal)
    
        self.snp.makeConstraints {
            $0.width.height.equalTo(56)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
