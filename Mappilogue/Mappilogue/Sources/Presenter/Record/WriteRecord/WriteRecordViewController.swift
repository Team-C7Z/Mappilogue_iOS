//
//  WriteRecordViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/27.
//

import UIKit
import Photos

class WriteRecordViewController: BaseViewController {
    var schedule: Schedule = Schedule()
    var onColorSelectionButtonTapped: (() -> Void)?
    private var colorList = dummyColorSelectionData()
    private var textContentCellHeight: CGFloat = 80
    
    private let titleColorStackView = UIStackView()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let stackView = UIStackView()
    private let categoryButton = CategoryButton()
    private let scheduleTitleColorView = ScheduleTitleColorView()
    private let colorSelectionView = ColorSelectionView()
    private let mainLocationButton = MainLocationButton()
    private let recordContentView = ContentView()
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
        
        setNavigationTitleAndBackButton("기록 쓰기", backButtonAction: #selector(presentAlert))

        titleColorStackView.axis = .vertical
        titleColorStackView.distribution = .equalSpacing
        titleColorStackView.spacing = 0
        
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 1
        stackView.backgroundColor = .colorEAE6E1
        
        categoryButton.addTarget(self, action: #selector(categoryButtonTapped), for: .touchUpInside)
        
        mainLocationButton.addTarget(self, action: #selector(mainLocationButtonTapped), for: .touchUpInside)
        
        recordContentView.stackViewHeightUpdated = {
            self.stackView.layoutIfNeeded()
            self.scrollToBottom()
        }
        
        saveRecordView.hideKeyboardButton.addTarget(self, action: #selector(dismissKeyboard), for: .touchUpInside)
        saveRecordView.saveRecordButton.addTarget(self, action: #selector(saveRecordButtonTapped), for: .touchUpInside)
        saveRecordView.galleryButton.addTarget(self, action: #selector(galleryButtonTapped), for: .touchUpInside)
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
        stackView.addArrangedSubview(recordContentView)
        view.addSubview(saveRecordView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
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
    
    @objc func presentAlert(_ sender: UIButton) {
        let alertViewController = AlertViewController()
        alertViewController.modalPresentationStyle = .overCurrentContext
        let alert = Alert(titleText: "이 기록을 임시저장할까요?",
                          messageText: "쓰기 버튼을 다시 누르면 불러올 수 있어요",
                          cancelText: "삭제",
                          doneText: "임시저장",
                          buttonColor: .color2EBD3D,
                          alertHeight: 161)
        alertViewController.configureAlert(with: alert)
        alertViewController.onCancelTapped = {
            self.navigationController?.popViewController(animated: true)
        }
        alertViewController.onDoneTapped = {
            self.navigationController?.popViewController(animated: true)
        }
        present(alertViewController, animated: false)
    }
    
    @objc func categoryButtonTapped() {
        let selectCategoryViewController = SelectCategoryViewController()
        navigationController?.pushViewController(selectCategoryViewController, animated: true)
    }
    
    private func configureScheduleTitleColorView() {
        if let color = schedule.color {
            scheduleTitleColorView.configure(false, title: schedule.title, color: color, isColorSelection: false)
        } else {
            let randomColorIndex = Int.random(in: 0...14)
            schedule.color = colorList[randomColorIndex]
            colorSelectionView.selectedColorIndex = randomColorIndex
        }
    }
    
    private func configureColorSelectionView() {
        if let index = colorList.firstIndex(where: { $0 == schedule.color }) {
            colorSelectionView.configure(index)
        }
    }
    
    private func configureMainLocationButton() {
        guard let location = schedule.location else { return }
        
        mainLocationButton.configure(location)
    }
    
    @objc func mainLocationButtonTapped() {
        let mainLocationViewController = MainLocationViewController()
        navigationController?.pushViewController(mainLocationViewController, animated: true)
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
        
        stackView.snp.remakeConstraints {
            $0.top.equalTo(contentView).offset(10)
            $0.leading.equalTo(contentView).offset(16)
            $0.trailing.equalTo(contentView).offset(-16)
            $0.bottom.equalTo(contentView).offset(isShowing ? -keyboardHeight : -58)
        }
        
        saveRecordView.snp.remakeConstraints {
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(view).offset(isShowing ? -keyboardHeight : -34)
            $0.height.equalTo(48)
        }
        
        saveRecordView.configure(isShowing)
        view.layoutIfNeeded()
    }
    
    @objc func galleryButtonTapped() {
        checkAlbumPermission()
    }
    
    private func checkAlbumPermission() {
        PHPhotoLibrary.requestAuthorization({ status in
            DispatchQueue.main.async {
                switch status {
                case .authorized:
                    self.showGalleyView()
                case .denied:
                    self.showGalleyPermissionAlert()
                case .notDetermined:
                    print("Album: 선택하지 않음")
                default:
                    break
                }
            }
        })
    }
    
    func showGalleyView() {
//        let picker = UIImagePickerController()
//        picker.sourceType = .photoLibrary
//        picker.delegate = self
//        present(picker, animated: false)
        let imagePickerViewController = ImagePickerViewController()
        //let navigationController = UINavigationController(rootViewController: imagePickerViewController)
        imagePickerViewController.modalPresentationStyle = .fullScreen
        present(imagePickerViewController, animated: true)
    }
    
    func showGalleyPermissionAlert() {
        let alertViewController = AlertViewController()
        alertViewController.modalPresentationStyle = .overCurrentContext
        let alert = Alert(titleText: "사진 접근 권한을 허용해 주세요",
                          messageText: "사진 접근 권한을 허용하지 않을 경우\n일부 기능을 사용할 수 없어요",
                          cancelText: "닫기",
                          doneText: "설정으로 이동",
                          buttonColor: .color2EBD3D,
                          alertHeight: 182)
        alertViewController.configureAlert(with: alert)
        alertViewController.onDoneTapped = {
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        present(alertViewController, animated: false)
    }
    
    @objc func saveRecordButtonTapped() {
        let savingRecordViewController = SavingRecordViewController()
        savingRecordViewController.modalPresentationStyle = .overFullScreen
        savingRecordViewController.onSaveComplete = {
            self.navigationController?.popViewController(animated: false)
        }
        present(savingRecordViewController, animated: false)
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
                scheduleTitleColorView.configure(false, title: schedule.title, color: color, isColorSelection: isSelected)
            }
        }
    }
    
    func selectColor() {
        colorSelectionView.onSelectedColor = { [weak self] selectedColorIndex in
            guard let self = self else { return }
            
            schedule.color = colorList[selectedColorIndex]
            configureScheduleTitleColorView()
        }
    }
}

//extension WriteRecordViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
//        picker.dismiss(animated: false)
//        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
//            let attachment = NSTextAttachment()
//            attachment.image = image
//            attachment.bounds = CGRect(origin: .zero, size: CGSize(width: 50, height: 50))
//            let attachmentString = NSAttributedString(attachment: attachment)
//            let lineBreak = NSAttributedString(string: "\n")
//            self.recordContentView.contentView.textStorage.append(lineBreak)
//            self.recordContentView.contentView.textStorage.append(attachmentString)
//        }
//    }
//}
