//
//  MyRecordContentImageView.swift
//  Mappilogue
//
//  Created by hyemi on 2023/09/10.
//

import UIKit

class MyRecordContentImageView: BaseView {
    var onImageTapped: ((String) -> Void)?
    
    private var recordImages: [String] = []
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(MyRecordContentImageCell.self, forCellWithReuseIdentifier: MyRecordContentImageCell.registerId)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    override func setupProperty() {
        super.setupProperty()
       
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(collectionView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(self)
        }
    }
    
    func configure(_ images: [String], size: CGFloat) {
        recordImages = images
       
        collectionView.snp.remakeConstraints {
            $0.top.equalTo(self).offset(16)
            $0.leading.bottom.trailing.equalTo(self)
            $0.height.equalTo((recordImages.count == 1 ? size : 288))
        }
    }
    
    private func presentImageDetailViewController() {
        let imageDetailViewController = ImageDetailViewController()
        imageDetailViewController.modalPresentationStyle = .overFullScreen
    }
}

extension MyRecordContentImageView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recordImages.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyRecordContentImageCell.registerId, for: indexPath) as? MyRecordContentImageCell else { return UICollectionViewCell() }
        
        let image = recordImages[indexPath.row]
        cell.configure(image)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = recordImages.count == 1 ? collectionView.bounds.width : 288
        return CGSize(width: size, height: size)
    }

    // 수평 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }

    // 수직 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let image = recordImages[indexPath.row]
        onImageTapped?(image)
    }
}
