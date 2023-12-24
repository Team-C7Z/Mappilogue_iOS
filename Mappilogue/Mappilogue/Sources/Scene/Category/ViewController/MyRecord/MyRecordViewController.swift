//
//  MyCategoryViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/03.
//

import UIKit

class MyRecordViewController: NavigationBarViewController {
    weak var coordinator: MyRecordCoordinator?
    
    let dummyRecord = dummyRecordData()
    var categoryId: Int = 0
    var categoryName: String = ""
    var onModifyCategory: ((String) -> Void)?
    var onDeleteCategory: (() -> Void)?
    var isNewWrite: Bool = false
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .grayF9F8F7
        collectionView.register(EmptyRecordCell.self, forCellWithReuseIdentifier: EmptyRecordCell.registerId)
        collectionView.register(RecordCell.self, forCellWithReuseIdentifier: RecordCell.registerId)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        popBar.onPopButtonTapped = {
            self.coordinator?.popViewController()
        }
        
//        setNavigationTitleAndBackButton(categoryName, backButtonAction: isNewWrite ? #selector(navigateToMyRecordViewController) : #selector(backButtonTapped))
        setMenuButtonItem()
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(collectionView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        collectionView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(88)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view)
        }
    }
    
    func setMenuButtonItem() {
        if categoryName != "전체" {
            setPopMenuBar(title: categoryName)
            popMenuBar.onMenuButtonTapped = {
                self.menuButtonItemTapped()
            }
        } else {
            setPopBar(title: categoryName)
        }
    }
    
    @objc func menuButtonItemTapped() {
        let editCategoryViewController = EditCategoryViewController()
        editCategoryViewController.modalPresentationStyle = .overFullScreen
        editCategoryViewController.categoryId = categoryId
        editCategoryViewController.categoryName = categoryName
//        editCategoryViewController.onModifyCategory = { categoryName in
//            self.title = categoryName
//            self.onModifyCategory?(categoryName)
//        }
        editCategoryViewController.onDeleteCategory = {
            self.onDeleteCategory?()
            self.navigationController?.popViewController(animated: false)
        }
        present(editCategoryViewController, animated: false)
    }
    
    private func navigateToRecordContentViewController() {
        let myRecordContentViewController = ContentViewController()
        navigationController?.pushViewController(myRecordContentViewController, animated: true)
    }
    
    @objc private func navigateToMyRecordViewController() {
        let myRecordViewController = MyRecordListViewController()
        navigationController?.pushViewController(myRecordViewController, animated: false)
    }
}

extension MyRecordViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dummyRecord.isEmpty ? 1 : dummyRecord.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if dummyRecord.isEmpty {
            let cell = configureEmptyRecordCell(for: indexPath, in: collectionView)
            return cell
        } else {
            let cell = configureRecordCell(for: indexPath, in: collectionView)
            return cell
        }
    }
    
    private func configureEmptyRecordCell(for indexPath: IndexPath, in collectionView: UICollectionView) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmptyRecordCell.registerId, for: indexPath) as? EmptyRecordCell else { return UICollectionViewCell() }
        return cell
    }
    
    private func configureRecordCell(for indexPath: IndexPath, in collectionView: UICollectionView) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecordCell.registerId, for: indexPath) as? RecordCell else { return UICollectionViewCell() }
        
        let record = dummyRecord[indexPath.row]
        cell.configure(with: record)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 32, height: dummyRecord.isEmpty ? collectionView.frame.height - 110 : 64)
    }
    
    // 수평 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // 수직 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigateToRecordContentViewController()
    }
}
