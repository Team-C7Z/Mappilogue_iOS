//
//  ScheduleTitleTextField.swift
//  MappilogueKit
//
//  Created by hyemi on 2023/12/04.
//

import UIKit

public class ScheduleTitleTextField: UITextField {
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        setScheduleTitleTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setScheduleTitleTextField() {
        font = .title02
        placeholder = "일정 제목을 적어 주세요"
        tintColor = .green2EBD3D
        returnKeyType = .done
    }
}
