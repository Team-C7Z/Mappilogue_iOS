//
//  WriteRecordViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/27.
//

import UIKit
import Photos
import MappilogueKit

class WriteRecordViewController: NavigationBarViewController {
    weak var coordinator: WriteRecordCoordinator?
    private var colorViewModel = ColorViewModel()
   
    private var colorList: [ColorListDTO] = []
    var schedule = Schedule2222()
    var onColorSelectionButtonTapped: (() -> Void)?
 
    private let titleColorStackView = UIStackView()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let stackView = UIStackView()
    private let categoryButton = SelectCategoryButton()
    private let scheduleTitleColorView = ScheduleTitleColorView()
    private let colorSelectionView = ColorSelectionView()
    private let mainLocationButton = SelectMainLocationButton()
    private let contentImageView = WrtieContentImageView()
    private let contentTextView = WriteContentTextView()
    private let saveRecordView = ImageSaveRecordView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setKeyboardObservers()
        configureScheduleTitleColorView()
        configureColorSelectionView()
        toggleColorSelectionView()
        selectColor()
        configureMainLocationButton()
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        setDefaultPopBar(title: "기록 쓰기")
        
        popBar.onPopButtonTapped = { [weak self] in
            guard let self = self else { return }
            
            presentAlert()
        }

        titleColorStackView.axis = .vertical
        titleColorStackView.distribution = .equalSpacing
        titleColorStackView.spacing = 0
        
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 0
        
        categoryButton.addTarget(self, action: #selector(categoryButtonTapped), for: .touchUpInside)
        
        mainLocationButton.addTarget(self, action: #selector(mainLocationButtonTapped), for: .touchUpInside)
        
        contentTextView.stackViewHeightUpdated = { [weak self] in
            guard let self = self else { return }
            
            stackView.layoutIfNeeded()
            scrollToBottom()
        }
        
        saveRecordView.hideKeyboardButton.addTarget(self, action: #selector(dismissKeyboard), for: .touchUpInside)
        saveRecordView.saveRecordButton.addTarget(self, action: #selector(saveRecordButtonTapped), for: .touchUpInside)
        saveRecordView.addImageButton.addTarget(self, action: #selector(addImageButtonTapped), for: .touchUpInside)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(categoryButton)
        stackView.addArrangedSubview(titleColorStackView)
        titleColorStackView.addArrangedSubview(scheduleTitleColorView)
        titleColorStackView.addArrangedSubview(colorSelectionView)
        stackView.addArrangedSubview(mainLocationButton)
        stackView.addArrangedSubview(contentImageView)
        stackView.addArrangedSubview(contentTextView)
        view.addSubview(saveRecordView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        scrollView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(88)
            $0.leading.bottom.trailing.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView)
            $0.width.equalTo(scrollView)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(10)
            $0.leading.equalTo(contentView).offset(16)
            $0.trailing.equalTo(contentView).offset(-16)
            $0.bottom.equalTo(contentView).offset(-58)
        }
        
        saveRecordView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(48)
        }
    }
    
    func presentAlert() {
        let alert = Alert(titleText: "이 기록을 임시저장할까요?",
                          messageText: "쓰기 버튼을 다시 누르면 불러올 수 있어요",
                          cancelText: "삭제",
                          doneText: "임시저장",
                          buttonColor: .green2EBD3D,
                          alertHeight: 161)
        coordinator?.showAlertViewController(alert: alert)
//        alertViewController.onCancelTapped = {
//            self.coordinator?.popViewController()
//        }
//        alertViewController.onDoneTapped = {
//            self.coordinator?.popViewController()
//        }

    }
    
    @objc func categoryButtonTapped() {
        coordinator?.showSelectCategoryViewController()
    }
    
    private func configureScheduleTitleColorView() {
//        if color = schedule.color {
//            scheduleTitleColorView.configure(false, title: schedule.title, color: color, isColorSelection: false)
//        } else {
//            let randomColorIndex = Int.random(in: 0...14)
//            schedule.color = colorList[randomColorIndex]
//            colorSelectionView.selectedColorIndex = randomColorIndex
//        }
    }
    
    private func configureColorSelectionView() {
//        if let index = colorList.firstIndex(where: { $0 == schedule.color }) {
//            colorSelectionView.configure(index, colorList: colorList)
//        }
    }
    
    private func configureMainLocationButton() {
        guard let location = schedule.location else { return }
        
        mainLocationButton.configure(location)
    }
    
    @objc func mainLocationButtonTapped() {
        coordinator?.showMainLocationViewController()
    }
    
    private func scrollToBottom() {
        let bottomOffset = CGPoint(x: 0, y: self.scrollView.contentSize.height - scrollView.bounds.size.height)
        scrollView.setContentOffset(bottomOffset, animated: true)
    }
    
    private func setKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        keyboardWillChange(notification, isShowing: true)
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        keyboardWillChange(notification, isShowing: false)
    }
    
    private func keyboardWillChange(_ notification: Notification, isShowing: Bool) {
        guard let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardHeight = keyboardFrame.cgRectValue.height
        stackView.snp.updateConstraints {
            if isShowing {
                $0.bottom.equalTo(contentView).offset(-keyboardHeight)
            } else {
                $0.bottom.equalTo(contentView).offset(-58)
            }
        }
        
        saveRecordView.snp.remakeConstraints {
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(view).offset(isShowing ? -keyboardHeight : -34)
            $0.height.equalTo(48)
        }
        
        saveRecordView.configure(isShowing)
        view.layoutIfNeeded()
    }
    
    @objc func addImageButtonTapped() {
        checkAlbumPermission()
    }
    
    private func checkAlbumPermission() {
        switch PHPhotoLibrary.authorizationStatus(for: .readWrite) {
        case .limited:
            showImagePickerViewController(.limited)
        case .authorized:
            showImagePickerViewController(.authorized)
        case .denied, .restricted:
            presentGalleyPermissionAlert()
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
                if status == .limited {
                    self.showImagePickerViewController(.limited)
                } else if status == .authorized {
                    self.showImagePickerViewController(.authorized)
                } else {
                    self.presentGalleyPermissionAlert()
                }
            }
            print("Album: 선택하지 않음")
        default:
            break
        }
    }

    func showImagePickerViewController(_ status: PHAuthorizationStatus) {
        DispatchQueue.main.async {
            self.coordinator?.showImagePickerViewController(authStatus: status, isProfile: false)
//            imagePickerViewController.onCompletion = { assets in
//                self.displayRecordImages(assets)
//            }
            
        }
    }
    
    func presentGalleyPermissionAlert() {
        DispatchQueue.main.async {
            let alert = Alert(titleText: "사진 접근 권한을 허용해 주세요",
                              messageText: "사진 접근 권한을 허용하지 않을 경우\n일부 기능을 사용할 수 없어요",
                              cancelText: "닫기",
                              doneText: "설정으로 이동",
                              buttonColor: .green2EBD3D,
                              alertHeight: 182)
            self.coordinator?.showGalleyPermissionAlertViewController(alert: alert)
//            alertViewController.onDoneTapped = {
//                if let url = URL(string: UIApplication.openSettingsURLString) {
//                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
//                }
//            }
        }
    }
    
    func displayRecordImages(_ assets: [PHAsset]) {
        contentImageView.configure(assets)
    }
    
    @objc func saveRecordButtonTapped() {
        coordinator?.showSavingRecordViewController(isNewWrite: true, schedule: schedule)
    }
}

extension WriteRecordViewController {
    func toggleColorSelectionView() {
        scheduleTitleColorView.onColorSelectionButtonTapped = { [weak self] isSelected in
            guard let self = self else { return }
            
            colorSelectionView.snp.remakeConstraints {
                $0.height.equalTo(isSelected ? 186 : 0)
            }
            
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
            
            if let color = schedule.color {
//                scheduleTitleColorView.configure(false, title: schedule.title, color: color, isColorSelection: isSelected)
            }
        }
    }
    
    func selectColor() {
        colorSelectionView.onSelectedColor = { [weak self] selectedColorIndex in
            guard let self = self else { return }
     
          //  schedule.color = colorList[selectedColorIndex]
            configureScheduleTitleColorView()
        }
    }
}

extension WriteRecordViewController: UITextViewDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}

extension WriteRecordViewController {
    private func getColorList() {
        colorViewModel.getColorList()
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("error: \(error.localizedDescription)")
                }
            } receiveValue: { response in
                guard let result = response.result else { return }

            }
            .store(in: &colorViewModel.cancellables)
    }
}
