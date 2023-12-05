//
//  ScheduleCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/13.
//

import UIKit
import MappilogueKit

class ScheduleCell: BaseCollectionViewCell {
    static let registerId = "\(ScheduleCell.self)"
    
    var id: Int = 0
    var onEditButtonTapped: ((Int) -> Void)?
    
    private let scheduleColorView = UIView()
    private let scheduleLabel = UILabel()
    private let scheduleTimeLabel = UILabel()
    private let scheduleLocationLabel = UILabel()
    private let editButton = UIButton()
    
    override func setupProperty() {
        super.setupProperty()
        
        scheduleColorView.layer.cornerRadius = 4
        
        scheduleLabel.textColor = .black1C1C1C
        scheduleLabel.font = .body02
        
        scheduleTimeLabel.textColor = .gray707070
        scheduleTimeLabel.font = .caption03
        
        scheduleLocationLabel.textColor = .gray707070
        scheduleLocationLabel.font = .caption03
        
        editButton.setImage(Images.image(named: .buttonEdit), for: .normal)
        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(scheduleColorView)
        contentView.addSubview(scheduleLabel)
        contentView.addSubview(scheduleTimeLabel)
        contentView.addSubview(scheduleLocationLabel)
        contentView.addSubview(editButton)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        scheduleColorView.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(9)
            $0.leading.equalTo(contentView)
            $0.width.height.equalTo(20)
        }
        
        scheduleLabel.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(8)
            $0.leading.equalTo(scheduleColorView.snp.trailing).offset(8)
        }
        
        scheduleTimeLabel.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(29)
            $0.leading.equalTo(scheduleColorView.snp.trailing).offset(8)
        }
        
        scheduleLocationLabel.snp.makeConstraints {
            $0.centerY.equalTo(scheduleTimeLabel)
            $0.leading.equalTo(scheduleTimeLabel.snp.trailing)
        }
        
        editButton.snp.makeConstraints {
            $0.centerY.trailing.equalTo(contentView)
            $0.width.equalTo(44)
            $0.height.equalTo(52)
        }
    }
    
    func configure(_ id: Int, schedule: SchedulesOnSpecificDate) {
        self.id = id
        scheduleLabel.text = schedule.title
        scheduleColorView.backgroundColor = UIColor.fromHex(schedule.colorCode)
        scheduleTimeLabel.text = schedule.areaTime
        scheduleLocationLabel.text = schedule.areaTime.isEmpty ? schedule.areaName : ", \(schedule.areaName)"
    }
    
    @objc func editButtonTapped() {
        onEditButtonTapped?(id)
    }
}
