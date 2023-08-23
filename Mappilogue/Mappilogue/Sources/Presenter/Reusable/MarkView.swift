//
//  MarkView.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/30.
//

import UIKit

class MarkView: BaseView {
    private var markImage = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        layer.cornerRadius = frame.height / 2
        
        addSubview(markImage)
        markImage.image = UIImage(named: "common_mark")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(heartWidth: CGFloat, heartHeight: CGFloat) {
        markImage.frame.size.width = heartWidth
        markImage.frame.size.height = heartHeight
        markImage.center = CGPoint(x: frame.width / 2, y: frame.height / 2)
    }
}
