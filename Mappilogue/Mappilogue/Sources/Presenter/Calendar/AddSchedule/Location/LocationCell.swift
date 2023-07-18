//
//  LocationCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/17.
//

import UIKit

class LocationCell: BaseTableViewCell {
    static let registerId = "\(LocationCell.self)"
    
    private let locationLabel = UILabel()
    private let addressLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 6, left: 20, bottom: 6, right: 20))
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        locationLabel.textColor = .color1C1C1C
        locationLabel.font = .title02
        
        addressLabel.textColor = .color707070
        addressLabel.font = .caption01
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        backgroundColor = .colorF9F8F7
        contentView.addSubview(locationLabel)
        contentView.addSubview(addressLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        locationLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(contentView)
        }
        
        addressLabel.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(25)
            $0.leading.trailing.equalTo(contentView)
        }
    }
    
    func configure(with title: String, address: String) {
        locationLabel.text = title
        addressLabel.text = address
    }
}
