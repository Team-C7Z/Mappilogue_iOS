//
//  LocationTimeCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/17.
//

import UIKit
import MappilogueKit

class LocationTimeCell: BaseCollectionViewCell {
    static let registerId = "\(LocationTimeCell.self)"
    
    var onSelectedLocation: ((IndexPath) -> Void)?
    var onSelectedTime: ((IndexPath) -> Void)?

    private var indexPath: IndexPath?
    private var isCheck: Bool = false
    
    private let locationLabel = UILabel()
    private let locationImage = UIImageView()
    private let timeButton = UIButton()
    private let timeImage = UIImageView()
    private let timeLabel = UILabel()
    private let timeLineView = UIView()
    private let editImage = UIImageView()
    private let checkButton = UIButton()
    
    override func prepareForReuse() {
        super.prepareForReuse()
  
        checkButton.setImage(Images.image(named: .buttonUncheck), for: .normal)
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        contentView.layer.cornerRadius = 12
        contentView.backgroundColor = .grayF5F3F0
        
        locationLabel.textColor = .color000000
        locationLabel.font = .subtitle01
        locationImage.image = UIImage(named: "location")
        
        timeButton.addTarget(self, action: #selector(timeButtonTapped), for: .touchUpInside)
        timeImage.image = Images.image(named: .imageTime)
        timeLabel.textColor = .gray707070
        timeLabel.font = .body02
        timeLineView.backgroundColor = .gray707070
        
        editImage.image = Images.image(named: .imageOrder)
        editImage.tintColor = .grayC9C6C2

        checkButton.setImage(Images.image(named: .buttonUncheck), for: .normal)
        checkButton.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
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
        contentView.addSubview(checkButton)
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
        
        checkButton.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.trailing.equalTo(contentView).offset(-13)
            $0.width.height.equalTo(24)
        }
    }
    
    func configure(_ indexPath: IndexPath, schedule: AddSchduleLocation, isDeleteMode: Bool) {
        self.indexPath = indexPath
        locationLabel.text = schedule.name
        timeLabel.text = schedule.time
        checkButton.isHidden = !isDeleteMode
        editImage.isHidden = isDeleteMode
    }
    
    @objc func timeButtonTapped(_ sender: UIButton) {
        guard let indexPath = indexPath else { return }
        onSelectedTime?(indexPath)
    }
    
    @objc func checkButtonTapped() {
        isCheck = !isCheck
        updateCheckButtonImage()
        
        guard let indexPath = indexPath else { return }
        onSelectedLocation?(indexPath)
    }
    
    private func updateCheckButtonImage() {
        let image = Images.image(named: isCheck ? .buttonCheck : .buttonUncheck)
        checkButton.setImage(image, for: .normal)
    }
}
