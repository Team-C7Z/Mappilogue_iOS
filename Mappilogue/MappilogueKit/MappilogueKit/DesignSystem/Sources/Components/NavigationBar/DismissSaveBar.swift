//
//  DismissSaveBar.swift
//  MappilogueKit
//
//  Created by hyemi on 2023/12/02.
//

import UIKit

public class DismissSaveBar: UIView {
    public var onDismissButtonTapped: (() -> Void)?
    public var onSaveButtonTapped: (() -> Void)?
    
    private let dismissButton = UIButton()
    private let titleLabel = UILabel()
    private let saveButton = UIButton()
    
    public init() {
        super.init(frame: CGRect.zero)
        
        setupProperty()
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupProperty() {
        dismissButton.setImage(Icons.icon(named: .dismiss), for: .normal)
        dismissButton.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
        titleLabel.font = .title02
        saveButton.setImage(Icons.icon(named: .save), for: .normal)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    func setupHierarchy() {
        addSubview(dismissButton)
        addSubview(titleLabel)
        addSubview(saveButton)
    }
    
    func setupLayout() {
        self.snp.makeConstraints {
            $0.height.equalTo(88)
        }
        
        dismissButton.snp.makeConstraints {
            $0.leading.equalTo(self).offset(16)
            $0.bottom.equalTo(self).offset(-10)
            $0.width.height.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalTo(self)
            $0.bottom.equalTo(self).offset(-10)
        }
        
        saveButton.snp.makeConstraints {
            $0.trailing.equalTo(self).offset(-17)
            $0.bottom.equalTo(self).offset(-10)
            $0.width.height.equalTo(24)
        }
    }
    
    public func configure(title: String) {
        titleLabel.text = title
    }
    
    @objc func dismissButtonTapped() {
        onDismissButtonTapped?()
    }
    
    @objc func saveButtonTapped() {
        onSaveButtonTapped?()
    }
}
