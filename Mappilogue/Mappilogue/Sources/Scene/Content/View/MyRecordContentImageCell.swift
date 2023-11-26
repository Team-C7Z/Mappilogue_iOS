//
//  MyRecordContentImageCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/09/10.
//

import UIKit

class MyRecordContentImageCell: BaseCollectionViewCell {
    static let registerId = "\(MyRecordContentImageCell.self)"
    
    private let recordImage = UIImageView()
    
    override func setupProperty() {
        super.setupProperty()
        
        recordImage.contentMode = .scaleAspectFill
        recordImage.layer.masksToBounds = true
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
      
        addSubview(recordImage)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        recordImage.snp.makeConstraints {
            $0.edges.equalTo(self)
        }
    }
    
    func configure(_ image: String) {
        recordImage.image = UIImage(named: image)
    }
}
