//
//  LocationTimeCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/17.
//

import UIKit

class LocationTimeCell: BaseTableViewCell {
    static let registerId = "\(LocationTimeCell.self)"
    
    weak var delegate: TimeButtonDelegate?
    
    private var index: Int?
    
    private let locationLabel = UILabel()
    private let locationImage = UIImageView()
    private let timeButton = UIButton()
    private let timeImage = UIImageView()
    private let timeLabel = UILabel()
    private let timeLineView = UIView()
    private let editImage = UIImageView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 8, right: 16))
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        contentView.layer.cornerRadius = 12
        contentView.backgroundColor = .colorF5F3F0
        
        locationLabel.textColor = .color000000
        locationLabel.font = .subtitle01
        locationImage.image = UIImage(named: "location")
        
        timeButton.addTarget(self, action: #selector(timeButtonTapped), for: .touchUpInside)
        
        timeImage.image = UIImage(named: "time")
        timeLabel.textColor = .color707070
        timeLabel.font = .body02
        timeLineView.backgroundColor = .color707070
        
        editImage.image = UIImage(named: "edit")
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(locationLabel)
        contentView.addSubview(locationImage)
        contentView.addSubview(timeButton)
        timeButton.addSubview(timeImage)
        timeButton.addSubview(timeLabel)
        timeButton.addSubview(timeLineView)
        contentView.addSubview(editImage)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        locationLabel.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(22)
            $0.leading.equalTo(contentView).offset(20)
        }
        
        locationImage.snp.makeConstraints {
            $0.centerY.equalTo(locationLabel)
            $0.leading.equalTo(locationLabel.snp.trailing)
            $0.width.height.equalTo(20)
        }
        
        timeButton.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(52)
            $0.leading.equalTo(contentView).offset(20)
            $0.width.equalTo(81)
            $0.height.equalTo(21)
        }
        
        timeImage.snp.makeConstraints {
            $0.centerY.equalTo(timeButton)
            $0.leading.equalTo(timeButton)
            $0.width.height.equalTo(15)
        }
        
        timeLabel.snp.makeConstraints {
            $0.centerY.equalTo(timeImage)
            $0.leading.equalTo(timeImage.snp.trailing).offset(6)
        }
        
        timeLineView.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom).offset(0.5)
            $0.leading.trailing.equalTo(timeLabel)
            $0.height.equalTo(1)
        }
        
        editImage.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.trailing.equalTo(contentView).offset(-10)
            $0.width.height.equalTo(24)
        }
    }
    
    func configure(_ index: Int, location: String, time: String) {
        self.index = index
        locationLabel.text = location
        timeLabel.text = time
    }
    
    @objc func timeButtonTapped(_ sender: UIButton) {
        guard let index = index else { return }
        delegate?.timeButtonTapped(index)
    }
}

protocol TimeButtonDelegate: AnyObject {
    func timeButtonTapped(_ index: Int)
}
