//
//  DeleteToastView.swift
//  MappilogueKit
//
//  Created by hyemi on 2023/12/02.
//

import UIKit

public class DeleteToastView: UIView {
    private let toastMessageView = UIView()
    private let toastMessageImage = UIImageView()
    private let toastMessageLabel = UILabel()
    private let undoButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupProperty()
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupProperty() {
        toastMessageView.layer.cornerRadius = 12
        toastMessageView.backgroundColor = .gray404040
        toastMessageImage.image = Images.image(named: .toastDelete)
        toastMessageLabel.text = "일정이 삭제되었어요"
        toastMessageLabel.textColor = .whiteFFFFFF
        toastMessageLabel.font = .body02
        undoButton.setTitle("되돌리기", for: .normal)
        undoButton.setTitleColor(.green43B54E, for: .normal)
        undoButton.titleLabel?.font = .body03
    }
    
    func setupHierarchy() {
        addSubview(toastMessageView)
        toastMessageView.addSubview(toastMessageImage)
        toastMessageView.addSubview(toastMessageLabel)
        toastMessageView.addSubview(undoButton)
    }
    
    func setupLayout() {
        toastMessageView.snp.makeConstraints {
            $0.width.equalTo(343)
            $0.height.equalTo(48)
        }
        
        toastMessageImage.snp.makeConstraints {
            $0.leading.equalTo(20)
            $0.centerY.equalTo(toastMessageView)
            $0.width.height.equalTo(16)
        }
        
        toastMessageLabel.snp.makeConstraints {
            $0.leading.equalTo(toastMessageImage.snp.trailing).offset(6)
            $0.centerY.equalTo(toastMessageView)
        }
        
        undoButton.snp.makeConstraints {
            $0.trailing.equalTo(toastMessageView.snp.trailing).offset(-10)
            $0.centerY.equalTo(toastMessageView)
            $0.width.equalTo(69)
            $0.height.equalTo(41)
        }
    }
}
