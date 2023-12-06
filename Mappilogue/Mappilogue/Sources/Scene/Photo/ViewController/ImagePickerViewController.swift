//
//  ImagePickerViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/19.
//

import UIKit
import Photos
import PhotosUI
import MappilogueKit

class ImagePickerViewController: ImagePickerNavigationViewController {
    var allPhotos = PHFetchResult<PHAsset>()
    var authStatus: PHAuthorizationStatus?
    var favoritePhotosAlbum =  PHFetchResult<PHAsset>()
    var userCollections = PHFetchResult<PHAssetCollection>()
    var currentAlbum = PHFetchResult<PHAsset>()
    let allPhotosOptions = PHFetchOptions()
    var selectedAssets: [PHAsset] = []
    
    var isProfile: Bool = false
    var isPhotoDirectory: Bool = false
    var onCompletion: (([PHAsset]) -> Void)?
    var maxPhotoSelectionCount = 0
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .grayF9F8F7
        collectionView.register(ImagePickerCell.self, forCellWithReuseIdentifier: ImagePickerCell.registerId)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    private let limitedPhotoSelectionView = LimitedPhotoSelectionView()
    private let photoDirectoryView = PhotoDirectoryView()
    private let toastMessage = ToastMessageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

      //  photoDirectoryPickerButtonTapped()
        
        PHPhotoLibrary.shared().register(self)
        
        allPhotosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        allPhotos = PHAsset.fetchAssets(with: allPhotosOptions)
   
        getFavoritePhotos()
        
        userCollections = PHAssetCollection.fetchAssetCollections(
            with: .album,
            subtype: .albumRegular,
            options: nil)
        
        if authStatus == .authorized {
            limitedPhotoSelectionView.isHidden = true
        }
        
        photoDirectoryView.configure(authStatus, allPhotos: allPhotos, favoritePhotosAlbum: favoritePhotosAlbum, userCollections: userCollections)
        
        currentAlbum = allPhotos
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        dismissSaveBar.onSaveButtonTapped = {
            self.onCompletion?(self.selectedAssets)
            self.navigationController?.popViewController(animated: false)
        }
        
        photoDirectoryPickerButton.addTarget(self, action: #selector(photoDirectoryPickerButtonTapped), for: .touchUpInside)
        
        limitedPhotoSelectionView.backgroundColor = .grayF9F8F7
        
        limitedPhotoSelectionView.addImagesButton.addTarget(self, action: #selector(addImagesButtonTapped), for: .touchUpInside)
        limitedPhotoSelectionView.setPermissionButton.addTarget(self, action: #selector(setPermissionButtonTapped), for: .touchUpInside)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()

        view.addSubview(collectionView)
        view.addSubview(limitedPhotoSelectionView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        collectionView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(98)
            $0.leading.trailing.equalTo(view)
            $0.bottom.equalTo(view).offset(authStatus == .limited ? -142 : 0)
        }
        
        limitedPhotoSelectionView.snp.makeConstraints {
            $0.leading.bottom.trailing.equalTo(view)
            $0.height.equalTo(142)
        }
    }
    
    @objc func photoDirectoryPickerButtonTapped() {
        togglePhotoViewMode()
    }
    
    private func togglePhotoViewMode() {
        isPhotoDirectory = !isPhotoDirectory
        if isPhotoDirectory {
            addPhotoDirectoryView()
        } else {
            removePhotoDirectoryView()
        }
    }
    
    private func getFavoritePhotos() {
        let favoriteOptios = PHFetchOptions()
        favoriteOptios.predicate = NSPredicate(format: "favorite == %@", NSNumber(value: true))
        
        let smartAlbums = PHAssetCollection.fetchAssetCollections(
            with: .smartAlbum,
            subtype: .smartAlbumFavorites,
            options: nil)
        
        if let favoritePhotosAlbum = smartAlbums.firstObject {
            self.favoritePhotosAlbum = PHAsset.fetchAssets(in: favoritePhotosAlbum, options: favoriteOptios)
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
        photoDirectoryView.configure(authStatus, allPhotos: allPhotos, favoritePhotosAlbum: favoritePhotosAlbum, userCollections: userCollections)
        
        view.addSubview(photoDirectoryView)
        
        photoDirectoryView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(88)
            $0.leading.bottom.trailing.equalTo(view)
        }
        
        photoDirectoryView.onDirectorySelection = { album in
            self.selectDirectory(album)
        }
    }
    
    private func removePhotoDirectoryView() {
        photoDirectoryView.removeFromSuperview()
    }
    
    private func checkCameraPermission() {
        AVCaptureDevice.requestAccess(for: .video) { permission in
            if permission {
                print("Camera: 권한 허용")
                DispatchQueue.main.async {
                    self.presentCameraViewController()
                }
            } else {
                print("Camera: 권한 거부")
                DispatchQueue.main.async {
                    self.presentCameraPermissionAlert()
                }
            }
        }
    }

    func presentCameraPermissionAlert() {
        let alertViewController = AlertViewController()
        alertViewController.modalPresentationStyle = .overCurrentContext
        let alert = Alert(titleText: "카메라 접근 권한을 허용해 주세요",
                          messageText: "카메라 접근 권한을 허용하지 않을 경우\n일부 기능을 사용할 수 없어요",
                          cancelText: "닫기",
                          doneText: "설정으로 이동",
                          buttonColor: .green2EBD3D,
                          alertHeight: 182)
        alertViewController.configureAlert(with: alert)
        alertViewController.onDoneTapped = {
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        self.present(alertViewController, animated: false)
    }

    private func presentCameraViewController() {
        let cameraViewController = CameraViewController()
        navigationController?.pushViewController(cameraViewController, animated: false)
    }
    
    func setToastMessage() {
        toastMessage.configure(message: "사진은 10개까지 업로드할 수 있어요", showUndo: false)
        view.addSubview(toastMessage)
        
        toastMessage.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func showToastMessage() {
        self.setToastMessage()
        
        UIView.animate(withDuration: 2, delay: 0, options: .curveLinear, animations: {
            
        }, completion: { (_) in
            UIView.animate(withDuration: 0.3, delay: 1, options: .curveEaseIn, animations: {
                self.toastMessage.alpha = 0.0
            }, completion: { (_) in
                self.toastMessage.alpha = 1.0
                self.toastMessage.removeFromSuperview()
            })
        })
    }
    
}

extension ImagePickerViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentAlbum.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImagePickerCell.registerId, for: indexPath) as? ImagePickerCell else { return UICollectionViewCell() }

        if indexPath.row == 0 {
            cell.configure(nil, isSelected: false, count: 0)
        } else {
            let asset = currentAlbum[indexPath.row - 1]
            let isSelected = selectedAssets.contains(asset)
            if let count = selectedAssets.firstIndex(of: asset) {
                cell.configure(asset, isSelected: isSelected, count: isProfile ? nil : count + 1)
            } else {
                cell.configure(asset, isSelected: isSelected, count: nil)
            }
        }
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            checkCameraPermission()
        } else {
            let asset = currentAlbum[indexPath.row - 1]
            
            if isProfile {
                selectedAssets = [asset]
            } else {
                if selectedAssets.count < 10 {
                    if let index = selectedAssets.firstIndex(where: { $0 == asset}) {
                        selectedAssets.remove(at: index)
                    } else {
                        selectedAssets.append(asset)
                    }
                } else {
                    showToastMessage()
                }
            }
        }
        collectionView.reloadData()
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

extension ImagePickerViewController {
    func selectDirectory(_ album: PHFetchResult<PHAsset>) {
        removePhotoDirectoryView()
        currentAlbum = album
        collectionView.reloadData()
    }
}
