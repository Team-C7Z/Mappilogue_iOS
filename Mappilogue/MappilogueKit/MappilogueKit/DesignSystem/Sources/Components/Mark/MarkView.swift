//
//  MarkView.swift
//  MappilogueKit
//
//  Created by hyemi on 2023/12/03.
//

import UIKit

public class MarkView: UIView {
    private var heartImage = UIImageView()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
    
        setMarkView(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setMarkView(frame: CGRect) {
        layer.cornerRadius = frame.height / 2
        
        addSubview(heartImage)
        heartImage.image = Images.image(named: .imageHeartMark)
    }
    
    public func configure(heartWidth: CGFloat, heartHeight: CGFloat) {
        heartImage.frame.size.width = heartWidth
        heartImage.frame.size.height = heartHeight
        heartImage.center = CGPoint(x: frame.width / 2, y: frame.height / 2)
    }
}
