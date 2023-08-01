//
//  markerView.swift
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
        markerImage.image = UIImage(named: "marker")
        
        recordImage = UIImageView(frame: CGRect(x: (frame.width - 32) / 2, y: 8, width: 32, height: 32))
        recordImage.image = UIImage(named: "marker_logo")
        recordImage.layer.cornerRadius = 16
       
        markerImage.addSubview(recordImage)
        addSubview(markerImage)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(image: String, color: UIColor) {
        markerImage.tintColor = color
    }
}
