//
//  SortView.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/30.
//

import UIKit

class SortView: BaseView {
    private let stackView = UIStackView()
    private let sortImage = UIImageView()
    private let sortLabel = UILabel()
    private let sortButton = UIButton()
    
    override func setupProperty() {
        super.setupProperty()
      
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 6
        
        sortImage.image = UIImage(named: "record_sort")
        
        updateSortButton()
        sortLabel.textColor = .color707070
        sortLabel.font = .body02
        
        sortButton.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(stackView)
        stackView.addArrangedSubview(sortImage)
        stackView.addArrangedSubview(sortLabel)
        stackView.addSubview(sortButton)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        self.snp.makeConstraints {
            $0.height.equalTo(32)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(self)
            $0.trailing.equalTo(self).offset(-16)
        }
        
        sortImage.snp.makeConstraints {
            $0.width.height.equalTo(16)
        }
        
        sortButton.snp.makeConstraints {
            $0.edges.equalTo(stackView)
        }
    }
    
    @objc func sortButtonTapped() {
        sortButton.isSelected = !sortButton.isSelected
        updateSortButton()
    }
    
    private func updateSortButton() {
        sortLabel.text = sortButton.isSelected ? "오래된 순" : "최신 순"
    }
}
