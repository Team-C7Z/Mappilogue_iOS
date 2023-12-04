//
//  SearchLocationCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/29.
//

import UIKit
import MappilogueKit

class SearchLocationCell: BaseCollectionViewCell {
    static let registerId = "\(SearchLocationCell.self)"
    
    private let locationImage = UIImageView()
    private let locationTitleLabel = UILabel()
    private let addressLabel = UILabel()
    
    override func setupProperty() {
        super.setupProperty()
        
        locationImage.image = Images.image(named: .imagePin)
        
        locationTitleLabel.textColor = .black1C1C1C
        locationTitleLabel.font = .title02
        
        addressLabel.textColor = .gray707070
        addressLabel.font = .caption01
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(locationImage)
        contentView.addSubview(locationTitleLabel)
        contentView.addSubview(addressLabel)
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
            $0.trailing.equalTo(contentView)
        }
    }
    
    func configure(with location: Location) {
        locationTitleLabel.text = location.title
        addressLabel.text = location.address
    }
}
