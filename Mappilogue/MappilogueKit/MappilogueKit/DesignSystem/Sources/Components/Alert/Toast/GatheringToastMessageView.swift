//
//  GatheringToastMessageView.swift
//  MappilogueKit
//
//  Created by hyemi on 2023/12/02.
//

import UIKit

public class GatheringToastMessageView: UIView {
    private let toastMessageView = UIView()
    private let toastMessageImage = UIImageView()
    private let toastMessageLabel = UILabel()
    private let toastMessageArrow = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupProperty()
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupProperty() {
        toastMessageView.layer.cornerRadius = 12
        toastMessageView.backgroundColor = .gray404040
        toastMessageImage.image = Images.image(named: .toastGathering)
        toastMessageLabel.text = "모임 기능은 나중에 만나요!"
        toastMessageLabel.textColor = .whiteFFFFFF
        toastMessageLabel.font = .body02
        toastMessageArrow.image = Images.image(named: .toastGatheringArrow)
    }
    
    func setupHierarchy() {
        addSubview(toastMessageView)
        toastMessageView.addSubview(toastMessageImage)
        toastMessageView.addSubview(toastMessageLabel)
        addSubview(toastMessageArrow)
    }
    
    func setupLayout() {
        toastMessageView.snp.makeConstraints {
            $0.bottom.equalTo(toastMessageArrow.snp.top).offset(4)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(206)
            $0.height.equalTo(37)
        }
        
        toastMessageImage.snp.makeConstraints {
            $0.leading.equalTo(18)
            $0.centerY.equalTo(toastMessageView)
            $0.width.height.equalTo(16)
        }
        
        toastMessageLabel.snp.makeConstraints {
            $0.leading.equalTo(toastMessageImage.snp.trailing).offset(6)
            $0.centerY.equalTo(toastMessageView)
        }
        
        toastMessageArrow.snp.makeConstraints {
            $0.centerX.bottom.equalToSuperview()
            $0.width.equalTo(19)
            $0.height.equalTo(14)
        }
    }
}
