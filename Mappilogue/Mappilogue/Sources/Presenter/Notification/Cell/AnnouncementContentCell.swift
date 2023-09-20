//
//  AnnouncementContentCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/09/14.
//

import UIKit

class AnnouncementContentCell: BaseTableViewCell {
    static let registerId = "\(AnnouncementContentCell.self)"
    
    private let contentTextView = UITextView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        contentTextView.textColor = .color000000
        contentTextView.font = .body02
        contentTextView.sizeToFit()
        contentTextView.backgroundColor = .clear
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(contentTextView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        contentTextView.snp.makeConstraints {
            $0.edges.equalTo(contentView)
        }
    }
    
    func configure(_ content: String) {
        contentTextView.setLineAndLetterSpacing(content)
    }
}
