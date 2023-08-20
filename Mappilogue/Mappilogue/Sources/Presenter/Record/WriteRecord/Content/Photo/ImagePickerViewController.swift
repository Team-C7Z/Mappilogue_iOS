//
//  ImagePickerViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/19.
//

import UIKit
import Photos
import PhotosUI

class ImagePickerViewController: BaseViewController {
    var authStatus: PHAuthorizationStatus?
    var allPhotos = PHFetchResult<PHAsset>()
    let allPhotosOptions = PHFetchOptions()
    
    var isPhotoDirectory: Bool = false
    
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
    
    private let limitedPhotoSelectionView = LimitedPhotoSelectionView()
    private let photoDirectoryView = PhotoDirectoryView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dismissButtonTapped()
        photoDirectoryPickerButtonTapped()
        completionButtonTapped()
        
        PHPhotoLibrary.shared().register(self)
        
        allPhotosOptions.sortDescriptors = [
            NSSortDescriptor(key: "creationDate", ascending: false)
        ]
        allPhotos = PHAsset.fetchAssets(with: allPhotosOptions)
        
        if authStatus == .authorized {
            limitedPhotoSelectionView.isHidden = true
        }
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        limitedPhotoSelectionView.backgroundColor = .colorF9F8F7
        
        limitedPhotoSelectionView.addImagesButton.addTarget(self, action: #selector(addImagesButtonTapped), for: .touchUpInside)
        limitedPhotoSelectionView.setPermissionButton.addTarget(self, action: #selector(setPermissionButtonTapped), for: .touchUpInside)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(navigationBar)
        view.addSubview(collectionView)
        view.addSubview(limitedPhotoSelectionView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(view)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.leading.trailing.equalTo(view)
            $0.bottom.equalTo(view).offset(authStatus == .limited ? -142 : 0)
        }
        
        limitedPhotoSelectionView.snp.makeConstraints {
            $0.leading.bottom.trailing.equalTo(view)
            $0.height.equalTo(142)
        }
    }
    
    private func dismissButtonTapped() {
        navigationBar.onDismiss = {
            self.dismiss(animated: true)
        }
    }
    
    private func photoDirectoryPickerButtonTapped() {
        navigationBar.onPhotoDirectoryPickerButtonTapped = {
            self.togglePhotoViewMode()
        }
    }
    
    private func togglePhotoViewMode() {
        isPhotoDirectory = !isPhotoDirectory
        if isPhotoDirectory {
            addPhotoDirectoryView()
        } else {
            removePhotoDirectoryView()
        }
    }
    
    private func completionButtonTapped() {
        navigationBar.onCompletion = {
            self.dismiss(animated: true)
        }
    }
    
    @objc private func addImagesButtonTapped() {
        PHPhotoLibrary.shared().presentLimitedLibraryPicker(from: self)
    }
    
    @objc private func setPermissionButtonTapped() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    private func addPhotoDirectoryView() {
        view.addSubview(photoDirectoryView)
        
        photoDirectoryView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.leading.bottom.trailing.equalTo(view)
        }
    }
    
    private func removePhotoDirectoryView() {
        photoDirectoryView.removeFromSuperview()
    }
}

extension ImagePickerViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImagePickerCell.registerId, for: indexPath) as? ImagePickerCell else { return UICollectionViewCell() }
        
        let asset = allPhotos[indexPath.row]
        cell.configure(asset)
        
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

extension ImagePickerViewController: PHPhotoLibraryChangeObserver {
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        guard let changes = changeInstance.changeDetails(for: allPhotos) else { return }
        allPhotos = changes.fetchResultAfterChanges
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
