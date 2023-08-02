//
//  MainLocationCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/02.
//

import UIKit

class MainLocationCell: BaseCollectionViewCell {
    static let registerId = "\(SearchLocationCell.self)"
    
    private let locationImage = UIImageView()
    private let locationTitleLabel = UILabel()
    private let addressLabel = UILabel()
    private let mainLocationButton = UIButton()
    
    override func setupProperty() {
        super.setupProperty()
        
        locationImage.image = UIImage(named: "searchLocation")
        
        locationTitleLabel.text = "카멜리아힐"
        locationTitleLabel.textColor = .color1C1C1C
        locationTitleLabel.font = .title02
        
        addressLabel.text = "제주 서귀포시 안덕면 병악로 166"
        addressLabel.textColor = .color707070
        addressLabel.font = .caption01
        
        mainLocationButton.setTitle("대표 위치", for: .normal)
        mainLocationButton.setTitleColor(.colorC9C6C2, for: .normal)
        mainLocationButton.titleLabel?.font = .caption02
        mainLocationButton.backgroundColor = .clear
        mainLocationButton.layer.borderWidth = 2
        mainLocationButton.layer.borderColor = UIColor.colorC9C6C2.cgColor
        mainLocationButton.layer.cornerRadius = 14
        
        mainLocationButton.addTarget(self, action: #selector(mainLocationButtonTapped), for: .touchUpInside)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(locationImage)
        contentView.addSubview(locationTitleLabel)
        contentView.addSubview(addressLabel)
        contentView.addSubview(mainLocationButton)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        locationImage.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(11)
            $0.leading.equalTo(contentView)
            $0.width.equalTo(16)
            $0.height.equalTo(20)
        }
        
        locationTitleLabel.snp.makeConstraints {
            $0.top.equalTo(contentView)
            $0.leading.equalTo(locationImage.snp.trailing).offset(8)
        }
        
        addressLabel.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(26)
            $0.leading.equalTo(locationTitleLabel)
            $0.trailing.equalTo(mainLocationButton.snp.leading).offset(-8)
        }
        
        mainLocationButton.snp.makeConstraints {
            $0.trailing.centerY.equalTo(contentView)
            $0.width.equalTo(65)
            $0.height.equalTo(28)
        }
    }
    
    func configure(with location: Location) {
        locationTitleLabel.text = location.title
        addressLabel.text = location.address
    }
    
    @objc func mainLocationButtonTapped(button: UIButton) {
        button.isSelected = !button.isSelected
        updateMainLocationDesign(button)
    }
    
    private func updateMainLocationDesign(_ button: UIButton) {
        button.setTitleColor(button.isSelected ? .colorFFFFFF : .colorC9C6C2, for: .normal)
        button.backgroundColor = button.isSelected ? .color2EBD3D : .clear
        button.layer.borderWidth = button.isSelected ? 0 : 2
    }
}
