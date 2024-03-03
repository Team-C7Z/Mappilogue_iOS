//
//  SearchBar.swift
//  MappilogueKit
//
//  Created by hyemi on 2023/12/04.
//

import UIKit

public class SearchBar: UISearchBar {
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        setSearchBar()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setSearchBar() {
        backgroundColor = .grayF9F8F7
        backgroundImage = UIImage()
        let directionalMargins = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        directionalLayoutMargins = directionalMargins
        
        if let textfield = value(forKey: "searchField") as? UITextField {
            textfield.autocorrectionType = .no
            textfield.spellCheckingType = .no
            textfield.backgroundColor = .grayF5F3F0
            textfield.attributedPlaceholder = NSAttributedString(string: textfield.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.grayC9C6C2])
            textfield.textColor = .black1C1C1C
            textfield.font = .body01
            textfield.tintColor = .green2EBD3D
            textfield.leftView = .none
        }
    }
    
    public func configure(_ placeholder: String) {
        self.placeholder = placeholder
    }
}
