//
//  MapSettingsHeaderView.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/15.
//

import UIKit

class MapSettingsHeaderView: BaseCollectionReusableView {
    static let registerId = "\(MapSettingsHeaderView.self)"

    var onMapSetting: (() -> Void)?

    private let mapSettingsButton = UIButton()
    private let mapSettingsLabel = UILabel()
    private let moveImage = UIImageView()

    override func layoutSubviews() {
        super.layoutSubviews()

        self.frame = self.frame.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
    }

    override func setupProperty() {
        super.setupProperty()

        mapSettingsButton.addTarget(self, action: #selector(setLocationButtonTapped), for: .touchUpInside)

        mapSettingsLabel.text = "지도에서 설정"
        mapSettingsLabel.textColor = .black1C1C1C
        mapSettingsLabel.font = .body02

        moveImage.image = UIImage(named: "moveWrite")
    }

    override func setupHierarchy() {
        super.setupHierarchy()

        addSubview(mapSettingsButton)
        mapSettingsButton.addSubview(mapSettingsLabel)
        mapSettingsButton.addSubview(moveImage)
    }

    override func setupLayout() {
        super.setupLayout()

        mapSettingsButton.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(self)
            $0.height.equalTo(40)
        }

        mapSettingsLabel.snp.makeConstraints {
            $0.leading.centerY.equalTo(mapSettingsButton)
        }

        moveImage.snp.makeConstraints {
            $0.trailing.centerY.equalTo(mapSettingsButton)
            $0.width.equalTo(7)
            $0.height.equalTo(14)
        }
    }

    @objc func setLocationButtonTapped() {
        onMapSetting?()
    }
}
