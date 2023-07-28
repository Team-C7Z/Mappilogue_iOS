//
//  SelectCategoryViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/28.
//

import UIKit

class SelectCategoryViewController: BaseViewController {
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .colorF9F8F7
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        collectionView.register(AddCategoryCell.self, forCellWithReuseIdentifier: AddCategoryCell.registerId)
        collectionView.register(NewCategoryCell.self, forCellWithReuseIdentifier: NewCategoryCell.registerId)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func setupProperty() {
        super.setupProperty()
        
        setNavigationBar()
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(collectionView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

    private func setNavigationBar() {
        title = "카테고리 선택"
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "back2"), for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        let barButtonItem = UIBarButtonItem(customView: button)
        navigationItem.leftBarButtonItem = barButtonItem
    }
    
    @objc func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension SelectCategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewCategoryCell.registerId, for: indexPath) as? NewCategoryCell else { return UICollectionViewCell() }
            return cell
        }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddCategoryCell.registerId, for: indexPath) as? AddCategoryCell else { return UICollectionViewCell() }
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 32, height: 40)
    }
    
    // 수평 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // 수직 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
    }
}
