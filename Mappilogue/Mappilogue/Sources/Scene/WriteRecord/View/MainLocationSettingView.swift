//
//  MainLocationSettingView.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/15.
//

import UIKit

class MainLocationSettingView: BaseView {
    var address: String = ""
    var onSelectedMapLocation: ((String) -> Void)?

    private let addressLabel = UILabel()
    private let setLocationButton = UIButton()

    override func setupProperty() {
        super.setupProperty()

        layer.cornerRadius = 24
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        layer.masksToBounds = true
        backgroundColor = .grayF9F8F7

        addressLabel.textColor = .color000000
        addressLabel.font = .title02

        setLocationButton.layer.cornerRadius = 12
        setLocationButton.backgroundColor = .green43B54E
        setLocationButton.setTitle("이 위치로 설정하기", for: .normal)
        setLocationButton.setTitleColor(.whiteFFFFFF, for: .normal)
        setLocationButton.titleLabel?.font = .body03
        setLocationButton.addTarget(self, action: #selector(setLocationButtonTapped), for: .touchUpInside)
    }

    override func setupHierarchy() {
        super.setupHierarchy()

        addSubview(addressLabel)
        addSubview(setLocationButton)
    }

    override func setupLayout() {
        super.setupLayout()

        self.snp.makeConstraints {
            $0.height.equalTo(200)
        }

        addressLabel.snp.makeConstraints {
            $0.top.equalTo(self).offset(24)
            $0.leading.equalTo(self).offset(16)
        }

        setLocationButton.snp.makeConstraints {
            $0.top.equalTo(self).offset(100)
            $0.leading.equalTo(self).offset(16)
            $0.trailing.equalTo(self).offset(-16)
            $0.height.equalTo(53)
        }
    }

    func configure(_ title: String) {
        addressLabel.text = title
        address = title
    }

    @objc func setLocationButtonTapped() {
        onSelectedMapLocation?(address)
    }
}
