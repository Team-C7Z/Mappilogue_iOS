//
//  MyRecordContentHeaderView.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/17.
//

import UIKit

class MyRecordContentHeaderView: BaseView {
    private let categoryNameLabel = UILabel()
    private let titleLabel = UILabel()
    private let locationImage = UIImageView()
    private let locationLabel = UILabel()
    private let dateLabel = UILabel()
    private let lineView = UIView()
    
    override func setupProperty() {
        super.setupProperty()
   
        categoryNameLabel.textColor = .color707070
        categoryNameLabel.font = .caption02
        
        titleLabel.textColor = .color1C1C1C
        titleLabel.font = .title01
        
        locationImage.image = UIImage(named: "record_location_fill")
        locationLabel.textColor = .color707070
        locationLabel.font = .body02
        
        dateLabel.textColor = .color707070
        dateLabel.font = .body02
        
        lineView.backgroundColor = .colorEAE6E1
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(categoryNameLabel)
        addSubview(titleLabel)
        addSubview(locationImage)
        addSubview(locationLabel)
        addSubview(dateLabel)
        addSubview(lineView)
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
        
        lineView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(self)
            $0.height.equalTo(1)
        }
    }
    
    func configure(_ schedule: Schedule) {
        categoryNameLabel.text = schedule.category
        titleLabel.text = schedule.title
        locationLabel.text = schedule.location
        dateLabel.text = schedule.time
    }
}
