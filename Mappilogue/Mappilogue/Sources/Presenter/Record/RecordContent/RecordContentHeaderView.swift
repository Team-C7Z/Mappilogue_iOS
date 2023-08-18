//
//  RecordContentHeaderView.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/17.
//

import UIKit

class RecordContentHeaderView: BaseView {
    private let categoryNameLabel = UILabel()
    private let titleLabel = UILabel()
    private let locationImage = UIImageView()
    private let locationLabel = UILabel()
    private let dateLabel = UILabel()
    
    override func setupProperty() {
        super.setupProperty()
        
        categoryNameLabel.text = "여행"
        categoryNameLabel.textColor = .color707070
        categoryNameLabel.font = .caption02
        
        titleLabel.text = "제주 여행"
        titleLabel.textColor = .color1C1C1C
        titleLabel.font = .title01
        
        locationImage.image = UIImage(named: "record_location_fill")
        locationLabel.text = "카멜리아힐"
        locationLabel.textColor = .color707070
        locationLabel.font = .body02
        
        dateLabel.text = "2023년 7월 14일"
        dateLabel.textColor = .color707070
        dateLabel.font = .body02
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(categoryNameLabel)
        addSubview(titleLabel)
        addSubview(locationImage)
        addSubview(locationLabel)
        addSubview(dateLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        self.snp.makeConstraints {
            $0.height.equalTo(96)
        }
        
        categoryNameLabel.snp.makeConstraints {
            $0.top.equalTo(self).offset(3)
            $0.leading.equalTo(self)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(self).offset(25)
            $0.leading.equalTo(self)
        }
        
        locationImage.snp.makeConstraints {
            $0.bottom.equalTo(self).offset(-11)
            $0.leading.equalTo(self)
            $0.width.equalTo(14)
            $0.height.equalTo(18)
        }
        
        locationLabel.snp.makeConstraints {
            $0.leading.equalTo(locationImage.snp.trailing).offset(8)
            $0.centerY.equalTo(locationImage)
        }
        
        dateLabel.snp.makeConstraints {
            $0.trailing.equalTo(self)
            $0.centerY.equalTo(locationImage)
        }
    }
}
