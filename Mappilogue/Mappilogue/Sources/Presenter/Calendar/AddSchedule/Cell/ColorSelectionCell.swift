//
//  ColorSelectionCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/14.
//

import UIKit

class ColorSelectionCell: BaseTableViewCell {
    static let registerId = "\(ColorSelectionCell.self)"
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .red
        collectionView.showsHorizontalScrollIndicator = false
        //collectionView.register(DayCell.self, forCellWithReuseIdentifier: DayCell.registerId)
        //collectionView.delegate = self
        //collectionView.dataSource = self
       
        return collectionView
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
    }
    
    override func setupProperty() {
        super.setupProperty()
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(collectionView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(contentView)
        }
    }
    
    func configure(color: UIColor) {
        
    }
}
