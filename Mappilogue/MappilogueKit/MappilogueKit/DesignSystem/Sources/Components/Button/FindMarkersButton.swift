//
//  FindMarkersButton.swift
//  MappilogueKit
//
//  Created by hyemi on 2023/12/04.
//

import UIKit

public class FindMarkersButton: UIButton {
    private let findImage = UIImageView()
    private let findLabel = UILabel()
    
    public init() {
        super.init(frame: .zero)
        
        setupProperty()
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupProperty() {
        layer.cornerRadius = 20
        backgroundColor = .grayF9F8F7
        
        findImage.image = UIImage(named: "record_find")
        
        findLabel.text = "현 지도에서 마크 찾기"
        findLabel.textColor = .color3C58EE
        findLabel.font = .body02
    }
    
    func setupHierarchy() {
        addSubview(findImage)
        addSubview(findLabel)
    }
    
    func setupLayout() {
        self.snp.makeConstraints {
            $0.width.equalTo(176)
            $0.height.equalTo(40)
        }
        
        findImage.snp.makeConstraints {
            $0.leading.equalTo(self).offset(16)
            $0.centerY.equalTo(self)
            $0.width.height.equalTo(18)
        }
        
        findLabel.snp.makeConstraints {
            $0.trailing.equalTo(self).offset(-16)
            $0.centerY.equalTo(self)
        }
    }
}
