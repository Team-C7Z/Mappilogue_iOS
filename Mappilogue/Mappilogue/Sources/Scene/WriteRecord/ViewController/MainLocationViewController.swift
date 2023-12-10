//
//  MainLocationViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/15.
//

import UIKit

class MainLocationViewController: NavigationBarViewController {
    var viewModel = MainLocationViewModel()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .grayF9F8F7

        collectionView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        collectionView.register(MainLocationCell.self, forCellWithReuseIdentifier: MainLocationCell.registerId)
        collectionView.register(MapSettingsHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MapSettingsHeaderView.registerId)
        collectionView.register(AddedLocationsHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: AddedLocationsHeaderView.registerId)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func setupProperty() {
        super.setupProperty()

        setPopBar(title: "대표 위치 설정")
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

    func setLocationButtonTapped() {
        let mapMainLocationViewController = MapMainLocationViewController()
        mapMainLocationViewController.onSelectedMapLocation = { address in
            self.viewModel.selectMapLocation(address)
            self.collectionView.reloadData()
        }
        navigationController?.pushViewController(mapMainLocationViewController, animated: true)
    }

    private func presentMainLocationAlert() {
        let mainLocationAlertViewController = MainLocationAlertViewController()
        mainLocationAlertViewController.modalPresentationStyle = .overCurrentContext
        mainLocationAlertViewController.onCanelTapped = {
            self.viewModel.selectMainLocation(1)
            self.collectionView.reloadData()
        }
        present(mainLocationAlertViewController, animated: false)
    }
}

extension MainLocationViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? (viewModel.selectedMapLocation == nil ? 0 : 1) : viewModel.dummyLocation.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainLocationCell.registerId, for: indexPath) as? MainLocationCell else { return UICollectionViewCell() }

        if indexPath.section == 0 {
            if let location = viewModel.selectedMapLocation {
                let isSelect = viewModel.selectedLocationIndex == -1
                cell.configure(-1, location: location, isSelect: isSelect)
            }
        } else {
            let location = viewModel.dummyLocation[indexPath.row]
            let isSelect = indexPath.row == viewModel.selectedLocationIndex
            cell.configure(indexPath.row, location: location, isSelect: isSelect)

            cell.onMainLocationSelection = { index in
                self.viewModel.selectMainLocation(index)
                if let index = index {
                    if index == 0 && self.viewModel.dummyLocation[index].address.isEmpty {
                        self.presentMainLocationAlert()
                    }
                }
            }
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: section == 0 ? 0 : 8, left: 16, bottom: 0, right: 16)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 32, height: 44)
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 0 {
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MapSettingsHeaderView.registerId, for: indexPath) as? MapSettingsHeaderView else { return UICollectionReusableView() }
            headerView.onMapSetting = {
                self.setLocationButtonTapped()
            }
            return headerView
        } else {
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: AddedLocationsHeaderView.registerId, for: indexPath) as? AddedLocationsHeaderView else { return UICollectionReusableView() }
            return headerView
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: section == 0 ? 40 : 18 + 16)
    }

    // 수평 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    // 수직 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
}
