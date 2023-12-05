//
//  WriteRecordButton.swift
//  MappilogueKit
//
//  Created by hyemi on 2023/12/03.
//

import UIKit

public class WriteRecordButton: UIButton {
    public init() {
        super.init(frame: .zero)
        
        setWriteRecordButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setWriteRecordButton() {
        layer.applyMainColorShadow()
        setImage(Images.image(named: .buttonWriteRecord), for: .normal)
        
        self.snp.makeConstraints {
            $0.width.height.equalTo(56)
        }
    }
}
