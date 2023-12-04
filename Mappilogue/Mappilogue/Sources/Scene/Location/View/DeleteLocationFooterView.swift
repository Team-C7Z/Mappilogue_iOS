//
//  DeleteLocationFooterView.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/17.
//

import UIKit
import MappilogueKit

class DeleteLocationHeaderView: BaseCollectionReusableView {
    static let registerId = "\(DeleteLocationHeaderView.self)"
    
    var onDeleteMode: (() -> Void)?
    var onDeleteLocation: (() -> Void)?

    private var isDeleteMode: Bool = false
    
    private let stackView = UIStackView()
    private let deleteSelectedButton = UIButton()
    private let deleteSelectedImage = UIImageView()
    private let deleteSelectedLabel = UILabel()
    private let deleteButton = UIButton()
    private let deleteImage = UIImageView()
    private let deleteLabel = UILabel()
    
    override func setupProperty() {
        super.setupProperty()
        
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 12
        
        deleteSelectedImage.image = Images.image(named: .imageDeleteLocation)
        deleteSelectedLabel.textColor = .gray707070
        deleteSelectedLabel.font = .body02
        deleteSelectedButton.addTarget(self, action: #selector(deleteSelectedButtonTapped), for: .touchUpInside)
        
        deleteImage.image = Images.image(named: .imageDelete)
        deleteImage.tintColor = .redF14C4C
        deleteLabel.text = "삭제하기"
        deleteLabel.textColor = .gray707070
        deleteLabel.font = .body02
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        
        switchDeleteMode()
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(stackView)
        stackView.addArrangedSubview(deleteSelectedButton)
        stackView.addArrangedSubview(deleteButton)
      
        deleteSelectedButton.addSubview(deleteSelectedImage)
        deleteSelectedButton.addSubview(deleteSelectedLabel)
        
        deleteButton.addSubview(deleteImage)
        deleteButton.addSubview(deleteLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        stackView.snp.makeConstraints {
            $0.centerY.equalTo(self)
            $0.trailing.equalTo(self).offset(-16)
        }
        
        deleteSelectedButton.snp.makeConstraints {
            $0.width.equalTo(71)
            $0.height.equalTo(32)
        }
        
        deleteSelectedImage.snp.makeConstraints {
            $0.trailing.equalTo(deleteSelectedLabel.snp.leading).offset(-6)
            $0.centerY.equalTo(deleteSelectedButton)
            $0.width.height.equalTo(16)
        }
        
        deleteSelectedLabel.snp.makeConstraints {
            $0.trailing.centerY.equalTo(deleteSelectedButton)
        }
        
        deleteButton.snp.makeConstraints {
            $0.width.equalTo(69)
            $0.height.equalTo(32)
        }
        
        deleteImage.snp.makeConstraints {
            $0.trailing.equalTo(deleteLabel.snp.leading).offset(-4)
            $0.centerY.equalTo(deleteButton)
            $0.width.height.equalTo(16)
        }
        
        deleteLabel.snp.makeConstraints {
            $0.trailing.centerY.equalTo(deleteButton)
        }
    }
    
    @objc func deleteSelectedButtonTapped(_ sender: UIButton) {
        isDeleteMode = !isDeleteMode
        switchDeleteMode()
     
        onDeleteMode?()
    }
    
    func switchDeleteMode() {
        deleteSelectedLabel.text = isDeleteMode ? "선택취소" : "선택삭제"
        deleteButton.isHidden = !isDeleteMode
        
        UIView.animate(withDuration: 0.3) {
            self.stackView.layoutIfNeeded()
        }
    }
    
    @objc func deleteButtonTapped(_ sender: UIButton) {
        onDeleteLocation?()
    }
}
