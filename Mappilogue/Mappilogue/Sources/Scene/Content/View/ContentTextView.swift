//
//  ContentTextView.swift
//  Mappilogue
//
//  Created by hyemi on 2023/09/10.
//

import UIKit

class ContentTextView: BaseView {
    var stackViewHeightUpdated: (() -> Void)?
    
    private let textView = UITextView()
    
    override func setupProperty() {
        super.setupProperty()
        
        textView.autocorrectionType = .no
        textView.spellCheckingType = .no
        textView.backgroundColor = .clear
        textView.isEditable = false
        textView.isScrollEnabled = false
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
       
        addSubview(textView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        textView.snp.makeConstraints {
            $0.top.equalTo(self).offset(14)
            $0.leading.trailing.bottom.equalTo(self)
        }
    }
    
    func configure(_ content: String, width: CGFloat) {
        textView.setLineAndLetterSpacing(content)
        textView.textColor = .black1C1C1C
        textView.font = .body01
      
        let newSize = textView.sizeThatFits(CGSize(width: width, height: CGFloat.greatestFiniteMagnitude))
    
        self.snp.updateConstraints {
            $0.height.equalTo(newSize.height + 50)
        }
      
        stackViewHeightUpdated?()
        self.layoutIfNeeded()
    }
}
