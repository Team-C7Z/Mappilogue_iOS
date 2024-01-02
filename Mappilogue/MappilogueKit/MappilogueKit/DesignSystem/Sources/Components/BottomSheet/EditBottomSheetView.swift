//
//  EditBottomSheetView.swift
//  MappilogueKit
//
//  Created by hyemi on 2023/12/04.
//

import UIKit

public class EditBottomSheetView: UIView {
    private let barView = UIView()
    public let modifyButton = UIButton()
    private let modifyImage = UIImageView()
    private let modifyLabel = UILabel()
    public let deleteButton = UIButton()
    private let deleteImage = UIImageView()
    private let deleteLabel = UILabel()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        setupProperty()
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupProperty() {
        self.layer.cornerRadius = 24
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.layer.masksToBounds = true
        self.backgroundColor = .grayF9F8F7
        
        barView.backgroundColor = .grayC9C6C2
        
        modifyImage.image = Images.image(named: .imageModify)
        modifyLabel.textColor = .black1C1C1C
        modifyLabel.font = .title02
        
        deleteImage.image = Images.image(named: .imageDelete)
        deleteImage.tintColor = .redF14C4C
        deleteLabel.textColor = .black1C1C1C
        deleteLabel.font = .title02
    }
    
    func setupHierarchy() {
        self.addSubview(barView)
        self.addSubview(modifyButton)
        modifyButton.addSubview(modifyImage)
        modifyButton.addSubview(modifyLabel)
        self.addSubview(deleteButton)
        deleteButton.addSubview(deleteImage)
        deleteButton.addSubview(deleteLabel)
    }
    
    func setupLayout() {
        self.snp.makeConstraints {
            $0.height.equalTo(216)
        }
        
        barView.snp.makeConstraints {
            $0.top.equalTo(self).offset(12)
            $0.centerX.equalTo(self)
            $0.width.equalTo(36)
            $0.height.equalTo(4)
        }
        
        modifyButton.snp.makeConstraints {
            $0.top.equalTo(self).offset(42)
            $0.leading.equalTo(self).offset(16)
            $0.trailing.equalTo(self).offset(16)
            $0.height.equalTo(56)
        }
        
        modifyImage.snp.makeConstraints {
            $0.leading.centerY.equalTo(modifyButton)
            $0.width.equalTo(18)
            $0.height.equalTo(17)
        }
        
        modifyLabel.snp.makeConstraints {
            $0.leading.equalTo(modifyImage.snp.trailing).offset(16)
            $0.centerY.equalTo(modifyButton)
        }
        
        deleteButton.snp.makeConstraints {
            $0.top.equalTo(modifyButton.snp.bottom)
            $0.leading.equalTo(self).offset(16)
            $0.trailing.equalTo(self).offset(-16)
            $0.height.equalTo(56)
        }
        
        deleteImage.snp.makeConstraints {
            $0.leading.centerY.equalTo(deleteButton)
            $0.width.equalTo(18)
            $0.height.equalTo(20)
        }
        
        deleteLabel.snp.makeConstraints {
            $0.leading.equalTo(deleteImage.snp.trailing).offset(15)
            $0.centerY.equalTo(deleteButton)
        }
    }
    
    public func configure(modifyTitle: String, deleteTitle: String, alert: Alert) {
        modifyLabel.text = modifyTitle
        deleteLabel.text = deleteTitle
    }
}
