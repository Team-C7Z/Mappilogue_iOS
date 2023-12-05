//
//  SaveRecordButton.swift
//  MappilogueKit
//
//  Created by hyemi on 2023/12/04.
//

import UIKit

public class SaveRecordButton: UIButton {
    public init() {
        super.init(frame: .zero)
        
        setupProperty()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupProperty() {
        setTitle("기록 저장", for: .normal)
        setTitleColor(.whiteFFFFFF, for: .normal)
        titleLabel?.font = .body03
        layer.cornerRadius = 35 / 2
        backgroundColor = .green2EBD3D
    }
}
