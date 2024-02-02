//
//  AddScheduleViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/13.
//

import UIKit
import MappilogueKit

class AddScheduleViewController: NavigationBarViewController {
    weak var coordinator: AddScheduleCoordinator?
    private var colorViewModel = ColorViewModel()
    var viewModel = ScheduleViewModel()
    
    var selectedColor: UIColor = .black1C1C1C
    
    var dragSectionIndex: Int = 0
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .grayF9F8F7
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        collectionView.register(LocationTimeCell.self, forCellWithReuseIdentifier: LocationTimeCell.registerId)
        collectionView.register(AddScheduleHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: AddScheduleHeaderView.registerId)
        collectionView.register(ScheduleDateFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: ScheduleDateFooterView.registerId)
        collectionView.register(DeleteLocationHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DeleteLocationHeaderView.registerId)
        collectionView.register(AddLocationFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: AddLocationFooterView.registerId)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.dragDelegate = self
        collectionView.dropDelegate = self
        return collectionView
    }()
    
    var keyboardTap = UITapGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        getColorList()
        viewModel.setCurrentDate()
        setKeyboardTap()
        loadScheduleData()
    }

    override func setupProperty() {
        super.setupProperty()

        setNavigationBar()
        
        keyboardTap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(collectionView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        collectionView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(88)
            $0.leading.bottom.trailing.equalToSuperview()
        }
    }
    
    func setNavigationBar() {
        setDismissSaveBar(title: "일정")
        dismissSaveBar.onDismissButtonTapped = {
            self.presentAlert()
        }
        dismissSaveBar.onSaveButtonTapped = {
            self.viewModel.saveSchedule()
            self.viewModel.onPop = {
                self.coordinator?.popViewController()
            }
        }
    }
    
    private func presentAlert() {
        let alert = Alert(titleText: "일정 작성을 중단할까요?",
                          messageText: "저장하지 않은 일정은 사라져요",
                          cancelText: "취소",
                          doneText: "나가기",
                          buttonColor: .redF14C4C,
                          alertHeight: 160)
        coordinator?.showAlertViewController(alert: alert)
    }
    
    func setKeyboardTap() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        view.addGestureRecognizer(keyboardTap)
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        view.removeGestureRecognizer(keyboardTap)
    }
    
    func loadScheduleData() {
        guard let id = viewModel.scheduleId else { return }
        viewModel.getSchedule(id: id)
        
        viewModel.$scheduleResult
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { result in
                guard let schedule = result else { return }
                self.viewModel.setScheduleData(getSchedule: schedule)
                self.collectionView.reloadData()
            })
            .store(in: &viewModel.cancellables)
    }

    func navigateToNotificationViewController() {
        coordinator?.showAddNotificationViewController()
//        addNotificationViewController.viewModel.onNotificationSelected = { alarmOptions in
//            self.viewModel.schedule.alarmOptions = alarmOptions
//        }
        
    }
    
    func presentAddLocationController() {
//        addLocationViewController.onLocationSelected = { location in
//            self.viewModel.selectLocation(location)
//            self.collectionView.reloadData()
//        }
//        DispatchQueue.main.async {
//            self.coordinator?.showAddLocationViewController()
//        }
//        
//
//        addLocationViewController.onLocationSelected = { location in
//            self.viewModel.selectLocation(location)
//            self.collectionView.reloadData()
//        }
        
        coordinator?.showAddLocationViewController()

    }
    
    func presentTimePicker(indexPath: IndexPath) {
        let selectedTime = viewModel.area[indexPath.section].value[indexPath.row].time
//        timePickerViewController.onSelectedTime = { selectedTime in
//            self.viewModel.area[indexPath.section].value[indexPath.row].time = self.viewModel.formatTime(selectedTime)
//            self.collectionView.reloadData()
//        }
        coordinator?.showTimePickerViewController(selectedTime: viewModel.setSelectedTime(selectedTime: selectedTime))
    }
    
    func presentDeleteLocationAlert() {
        guard !viewModel.selectedLocations.isEmpty else { return }

        let alert = Alert(titleText: "선택한 장소를 삭제할까요?",
                          cancelText: "취소",
                          doneText: "삭제",
                          buttonColor: .redF14C4C,
                          alertHeight: 140)
//        alertViewController.onDoneTapped = {
//            self.viewModel.deleteSelectedLocations()
//            self.collectionView.reloadData()
//        }
        
        coordinator?.showAlertViewController(alert: alert)
    }
}

extension AddScheduleViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.area.isEmpty ? 1 : 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? 0 : viewModel.area[viewModel.selectedDateIndex].value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LocationTimeCell.registerId, for: indexPath) as? LocationTimeCell else { return UICollectionViewCell() }
        
        let location = viewModel.area[viewModel.selectedDateIndex].value[indexPath.row]
        cell.configure([viewModel.selectedDateIndex, indexPath.row], schedule: location, isDeleteMode: viewModel.isDeleteMode)

        cell.onSelectedLocation = { indexPath in
            self.viewModel.toggleSelectedLocation(at: indexPath)
        }
        cell.onSelectedTime = { indexPath in
            self.presentTimePicker(indexPath: indexPath)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 32, height: 96)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            switch indexPath.section {
            case 0:
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: AddScheduleHeaderView.registerId, for: indexPath) as! AddScheduleHeaderView
                configureAddScheduleHeaderView(headerView)
                return headerView
            default:
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: DeleteLocationHeaderView.registerId, for: indexPath) as! DeleteLocationHeaderView
                configureDeleteLocationHeaderView(headerView)
                return headerView
            }
        } else if kind == UICollectionView.elementKindSectionFooter {
            if !viewModel.area.isEmpty && indexPath.section == 0 {
                let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ScheduleDateFooterView.registerId, for: indexPath) as! ScheduleDateFooterView
                footerView.configure(viewModel.area)
                footerView.onDateTapped = { index in
                    self.viewModel.selectedDateIndex = index
                    self.collectionView.reloadData()
                }
                return footerView
            }
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: AddLocationFooterView.registerId, for: indexPath) as! AddLocationFooterView
            footerView.onAddLocationButtonTapped = {
                self.presentAddLocationController()
            }
            return footerView
        }
        return UICollectionReusableView()
    }

    func configureAddScheduleHeaderView(_ headerView: AddScheduleHeaderView) {
        headerView.configureTitleColor(title: viewModel.schedule.title ?? "",
                                       isColorSelection: viewModel.isColorSelection,
                                       colorId: viewModel.schedule.colorId)
        headerView.configureDate(startDate: viewModel.startDate, endDate: viewModel.endDate, dateType: viewModel.scheduleDateType)
        headerView.configureColorList(viewModel.colorList)
        
        headerView.onScheduleTitle = { title in
            self.viewModel.schedule.title = title
        }
        
        headerView.onColorSelectionButtonTapped = {
            self.viewModel.isColorSelection.toggle()
            self.collectionView.performBatchUpdates(nil, completion: nil)
        }
        
        headerView.onColorIndex = { colorId in
            self.viewModel.schedule.colorId = colorId
            headerView.configureTitleColor(title: self.viewModel.schedule.title ?? "", isColorSelection: self.viewModel.isColorSelection, colorId: self.viewModel.schedule.colorId)
        }
        
        headerView.onNotificationButtonTapped = { self.navigateToNotificationViewController()}
    }
    
    func configureDeleteLocationHeaderView(_ headerView: DeleteLocationHeaderView) {
        headerView.onDeleteMode = {
            self.viewModel.isDeleteMode.toggle()
            self.collectionView.reloadData()
        }
        headerView.onDeleteLocation = {
            self.presentDeleteLocationAlert()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: section == 0 ? (viewModel.isColorSelection ? 411 : 225) : 32)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: !viewModel.area.isEmpty && section == 0 ? 72 : 53)
    }
    
    // 수평 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // 수직 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
}

extension AddScheduleViewController: UICollectionViewDragDelegate {
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        if viewModel.isDeleteMode {
            return []
        }
        dragSectionIndex = indexPath.section
        return [UIDragItem(itemProvider: NSItemProvider())]
    }
}

extension AddScheduleViewController: UICollectionViewDropDelegate {
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        if session.localDragSession != nil && destinationIndexPath?.section == dragSectionIndex {
            return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
        return UICollectionViewDropProposal(operation: .cancel, intent: .unspecified)
    }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        guard let destinationIndexPath = coordinator.destinationIndexPath else {
            return
        }
        
        coordinator.items.forEach { dropItem in
            guard let sourceIndexPath = dropItem.sourceIndexPath else { return }
            
            if sourceIndexPath.section != destinationIndexPath.section {
                return
            }
            
            collectionView.performBatchUpdates({
                collectionView.deleteItems(at: [sourceIndexPath])
                collectionView.insertItems(at: [destinationIndexPath])
                
                viewModel.updateLocationPosition(sourceIndexPath: sourceIndexPath, destinationIndexPath: destinationIndexPath)
    
            }, completion: { _ in
                coordinator.drop(dropItem.dragItem, toItemAt: destinationIndexPath)
                    collectionView.reloadData()
                }
            )
        }
    }
}

extension AddScheduleViewController {
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

                self.viewModel.colorList = result
                self.collectionView.reloadData()
            }
            .store(in: &colorViewModel.cancellables)
    }
}
