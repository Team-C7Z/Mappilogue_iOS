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
        
        recordImage = UIImageView(frame: CGRect(x: (frame.width - 31) / 2, y: 8.5, width: 31, height: 31))
        markerImage.addSubview(recordImage)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        markerImage.image = UIImage(named: "record_marker")
        
        recordImage.layer.cornerRadius = 16
        recordImage.layer.masksToBounds = true
    }
    
    func configure(image: String?, color: UIColor) {
        if let image = image {
            recordImage.image = UIImage(named: image)
        } else {
            recordImage.image = UIImage(named: "record_marker_logo")
        }
        markerImage.tintColor = color
    }
}
