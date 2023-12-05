//
//  MainLocationView.swift
//  MappilogueKit
//
//  Created by hyemi on 2023/12/03.
//

import UIKit

public class MainLocationView: UIView {
    private let mainLocationImage = UIImageView()
    private let mainLocationLabel = UILabel()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
    
        setupProperty()
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupProperty() {
        layer.cornerRadius = 14
        backgroundColor = .green2EBD3D
        
        mainLocationImage.image = Images.image(named: .imageMainLocationPin)
        
        mainLocationLabel.text = "대표 위치"
        mainLocationLabel.textColor = .whiteFFFFFF
        mainLocationLabel.font = .caption02
    }
    
    func setupHierarchy() {
        addSubview(mainLocationImage)
        addSubview(mainLocationLabel)
    }
    
    func setupLayout() {
        self.snp.makeConstraints {
            $0.width.equalTo(87)
            $0.height.equalTo(28)
        }
        
        mainLocationImage.snp.makeConstraints {
            $0.centerY.equalTo(self)
            $0.leading.equalTo(self).offset(10)
            $0.width.equalTo(14)
            $0.height.equalTo(18)
        }
        
        mainLocationLabel.snp.makeConstraints {
            $0.centerY.equalTo(self)
            $0.leading.equalTo(mainLocationImage.snp.trailing).offset(8)
        }
    }
}
