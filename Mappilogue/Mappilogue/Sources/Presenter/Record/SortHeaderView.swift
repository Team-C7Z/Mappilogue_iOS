//
//  SortHeaderView.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/30.
//

import UIKit

class SortHeaderView: BaseCollectionReusableView {
    static let registerId = "\(SortHeaderView.self)"
    
    private let stackView = UIStackView()
    private let sortImage = UIImageView()
    private let sortLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.frame = self.frame.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
    }
    
    override func setupProperty() {
        super.setupProperty()
      
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 6
        
        sortImage.image = UIImage(named: "sort")
        
        sortLabel.text = "최신 순"
        sortLabel.textColor = .color707070
        sortLabel.font = .body02
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(stackView)
        stackView.addArrangedSubview(sortImage)
        stackView.addArrangedSubview(sortLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        stackView.snp.makeConstraints {
            $0.top.trailing.equalTo(self)
        }
        
        sortImage.snp.makeConstraints {
            $0.width.height.equalTo(16)
        }
    }
}
