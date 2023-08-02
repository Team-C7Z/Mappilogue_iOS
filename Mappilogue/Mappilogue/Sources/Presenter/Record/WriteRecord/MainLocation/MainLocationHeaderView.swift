//
//  MainLocationHeaderView.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/02.
//

import UIKit

class MainLocationHeaderView: BaseCollectionReusableView {
    static let registerId = "\(MainLocationHeaderView.self)"
    
    weak var delegate: SetLocationButtonDelegate?
    
    private let setLocationButton = UIButton()
    private let setLabel = UILabel()
    private let moveImage = UIImageView()
    private let locationHeaderLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.frame = self.frame.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        setLocationButton.addTarget(self, action: #selector(setLocationButtonTapped), for: .touchUpInside)
        
        setLabel.text = "지도에서 설정"
        setLabel.textColor = .color1C1C1C
        setLabel.font = .body02
        
        moveImage.image = UIImage(named: "moveWrite")
        
        locationHeaderLabel.text = "일정에서 추가한 장소"
        locationHeaderLabel.textColor = .color707070
        locationHeaderLabel.font = .caption01
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(setLocationButton)
        setLocationButton.addSubview(setLabel)
        setLocationButton.addSubview(moveImage)
        addSubview(locationHeaderLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        setLocationButton.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(self)
            $0.height.equalTo(40)
        }
        
        setLabel.snp.makeConstraints {
            $0.leading.centerY.equalTo(setLocationButton)
        }
        
        moveImage.snp.makeConstraints {
            $0.trailing.centerY.equalTo(setLocationButton)
            $0.width.equalTo(7)
            $0.height.equalTo(14)
        }
        
        locationHeaderLabel.snp.makeConstraints {
            $0.leading.bottom.equalTo(self)
        }
    }
    
    @objc func setLocationButtonTapped() {
        delegate?.setLocationButtonTapped()
    }
}

protocol SetLocationButtonDelegate: AnyObject {
    func setLocationButtonTapped()
}
