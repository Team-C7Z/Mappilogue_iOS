//
//  MarkerView.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/01.
//

import UIKit

class MarkerView: BaseView {
    var markerImage = UIImageView()
    var recordImage = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        markerImage = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        addSubview(markerImage)
        
        recordImage = UIImageView(frame: CGRect(x: (frame.width - 32) / 2, y: 8, width: 32, height: 32))
        markerImage.addSubview(recordImage)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        markerImage.image = UIImage(named: "marker")
        
        recordImage.image = UIImage(named: "marker_logo")
        recordImage.layer.cornerRadius = 16
    }
    
    func configure(image: String, color: UIColor) {
        markerImage.tintColor = color
    }
}
