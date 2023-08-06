//
//  MarkView.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/30.
//

import UIKit

class MarkView: BaseView {
    private let markImage = UIImageView()
    
    convenience init(radius: CGFloat, width: CGFloat, height: CGFloat) {
        self.init(frame: .zero)
        
        self.layer.cornerRadius = radius
        self.layer.applyShadow()
        
        markImage.snp.makeConstraints {
            $0.width.equalTo(width)
            $0.height.equalTo(height)
            $0.centerX.centerY.equalTo(self)
        }
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        markImage.image = UIImage(named: "mark")
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(markImage)
    }
}
