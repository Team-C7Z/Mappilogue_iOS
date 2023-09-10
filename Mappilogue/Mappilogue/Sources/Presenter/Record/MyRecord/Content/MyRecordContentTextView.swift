//
//  MyRecordContentTextView.swift
//  Mappilogue
//
//  Created by hyemi on 2023/09/10.
//

import UIKit

class MyRecordContentTextView: BaseView {
    private let textView = UITextView()
    
    override func setupProperty() {
        super.setupProperty()
        
        textView.isEditable = false
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
       
        addSubview(textView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        textView.snp.makeConstraints {
            $0.top.equalTo(self).offset(16)
            $0.leading.trailing.bottom.equalTo(self)
        }
    }
    
    func configure(_ content: String) {
        textView.setLineAndLetterSpacing(content)
        textView.textColor = .color1C1C1C
        textView.font = .body01
        
        let fixedWidth = textView.frame.size.width
        let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        
        self.snp.updateConstraints {
            $0.height.equalTo(newSize.height + 50)
        }
      
        self.layoutIfNeeded()
    }
}
