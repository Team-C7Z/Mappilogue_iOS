//
//  ContentImageView.swift
//  Mappilogue
//
//  Created by hyemi on 2023/09/09.
//

import UIKit
import Photos

class ContentImageView: BaseView {
    private var assets: [PHAsset] = []
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.register(ContentImageCell.self, forCellWithReuseIdentifier: ContentImageCell.registerId)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    private let lineView = UIView()
    
    override func setupProperty() {
        super.setupProperty()
        
        lineView.backgroundColor = .colorEAE6E1
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(collectionView)
        addSubview(lineView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        self.snp.makeConstraints {
            $0.height.equalTo(0)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(self).offset(12)
            $0.leading.trailing.equalTo(self)
            $0.height.equalTo(100)
        }
        
        lineView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(self)
            $0.height.equalTo(1)
        }
    }
    
    func configure(_ assets: [PHAsset]) {
        self.assets += assets
        
        self.snp.updateConstraints {
            $0.height.equalTo(assets.isEmpty ? 0 : 133)
        }
        
        collectionView.reloadData()
    }
}

extension ContentImageView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return assets.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentImageCell.registerId, for: indexPath) as? ContentImageCell else { return UICollectionViewCell() }

        let asset = assets[indexPath.row]
        cell.configure(asset, isMain: false, isSelected: false)
        
        return cell
    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: , left: 16, bottom: 0, right: 16)
//    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }

    // 수평 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    // 수직 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}
