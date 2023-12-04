//
//  MarkerView.swift
//  MappilogueKit
//
//  Created by hyemi on 2023/12/04.
//

import UIKit

public class MarkerView: UIView {
    var markerImage = UIImageView()
    var recordImage = UIImageView()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(frame: CGRect) {
        markerImage = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        addSubview(markerImage)
        
        recordImage = UIImageView(frame: CGRect(x: (frame.width - 31) / 2, y: 8.5, width: 31, height: 31))
        markerImage.addSubview(recordImage)
        
        markerImage.image = UIImage(named: "record_marker")
        
        recordImage.layer.cornerRadius = 16
        recordImage.layer.masksToBounds = true
    }
    
    public func configure(image: String?, color: UIColor) {
        if let image = image {
            recordImage.image = UIImage(named: image)
        } else {
            recordImage.image = UIImage(named: "record_marker_logo")
        }
        markerImage.tintColor = color
    }
}
