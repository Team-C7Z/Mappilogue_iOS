//
//  ColorSelectionCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/14.
//

import UIKit

class ColorSelectionCell: BaseTableViewCell {
    static let registerId = "\(ColorSelectionCell.self)"
    
    private let dummyColorData = dummyColorSelectionData()
    private var selectedColorIndex = 0
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .colorFFFFFF
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(ColorCell.self, forCellWithReuseIdentifier: ColorCell.registerId)
        collectionView.delegate = self
        collectionView.dataSource = self
       
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

extension ColorSelectionCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dummyColorData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorCell.registerId, for: indexPath) as? ColorCell else { return UICollectionViewCell() }
        
        let isColorSelected = indexPath.row == selectedColorIndex
        
        cell.configure(with: dummyColorData[indexPath.row], isColorSelected: isColorSelected)
        
        return cell
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 32, height: 32)
    }

    // 수평 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 36
    }

    // 수직 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 18
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 27, left: 20, bottom: 27, right: 19)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedColorIndex = indexPath.row
        
        collectionView.reloadData()
    }
}
