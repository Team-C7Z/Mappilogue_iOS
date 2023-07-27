//
//  TextContentCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/27.
//

import UIKit

class TextContentCell: BaseTableViewCell {
    static let registerId = "\(TextContentCell.self)"
    
    private let lineView = UIView()
    private let contentTextView = UITextView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        lineView.backgroundColor = .colorEAE6E1
        
        contentTextView.text = "내용을 입력하세요"
        contentTextView.textColor = .colorC9C6C2
        contentTextView.font = .body01
        contentTextView.backgroundColor = .clear
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(lineView)
        contentView.addSubview(contentTextView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        lineView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(contentView)
            $0.height.equalTo(1)
        }
        
        contentTextView.snp.makeConstraints {
            $0.leading.trailing.equalTo(contentView)
            $0.top.equalTo(contentView).offset(16)
            $0.bottom.equalTo(contentView).offset(-16)
        }
    }
}
