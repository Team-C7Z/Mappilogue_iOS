//
//  SearchBar.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/16.
//

import UIKit

class SearchBar: UISearchBar {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .grayF9F8F7
        backgroundImage = UIImage()
        let directionalMargins = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        directionalLayoutMargins = directionalMargins
        
        if let textfield = value(forKey: "searchField") as? UITextField {
            textfield.backgroundColor = .grayF5F3F0
            textfield.attributedPlaceholder = NSAttributedString(string: textfield.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.grayC9C6C2])
            textfield.textColor = .black1C1C1C
            textfield.font = .body01
            textfield.tintColor = .green2EBD3D
            textfield.leftView = .none
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure(_ placeholder: String) {
        self.placeholder = placeholder
    }
}
