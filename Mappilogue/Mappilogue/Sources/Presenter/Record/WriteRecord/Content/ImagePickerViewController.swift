//
//  ImagePickerViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/19.
//

import UIKit
import Photos

class ImagePickerViewController: BaseViewController {
    private let navigationBar = CustomNavigationBar()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .colorF9F8F7
        collectionView.register(ImagePickerCell.self, forCellWithReuseIdentifier: ImagePickerCell.registerId)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dismissButtonTapped()
        completionButtonTapped()
    }
    
    override func setupProperty() {
        super.setupProperty()
        
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(navigationBar)
        view.addSubview(collectionView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(view)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.leading.trailing.bottom.equalTo(view)
        }
    }
    
    private func dismissButtonTapped() {
        navigationBar.onDismiss = {
            self.dismiss(animated: true)
        }
    }
    
    private func completionButtonTapped() {
        navigationBar.onCompletion = {
            self.dismiss(animated: true)
        }
    }
}

extension ImagePickerViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImagePickerCell.registerId, for: indexPath) as? ImagePickerCell else { return UICollectionViewCell() }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.width - 10) / 3
        return CGSize(width: size, height: size)
    }
    
    // 수평 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // 수직 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}
