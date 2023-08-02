//
//  SelectCategoryViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/28.
//

import UIKit

struct CategoryData {
    var title: String
    var count: Int
}

class SelectCategoryViewController: BaseViewController {
    var dummyCategory: [CategoryData] = [CategoryData(title: "여행", count: 1), CategoryData(title: "생일", count: 0)]
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .colorF9F8F7
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        collectionView.register(AddNewCategoryCell.self, forCellWithReuseIdentifier: AddNewCategoryCell.registerId)
        collectionView.register(NewCategoryCell.self, forCellWithReuseIdentifier: NewCategoryCell.registerId)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        setNavigationBar("카테고리 선택", backButtonAction: #selector(backButtonTapped))
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
}

extension SelectCategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? dummyCategory.count : 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewCategoryCell.registerId, for: indexPath) as? NewCategoryCell else { return UICollectionViewCell() }
            
            let cateogry = dummyCategory[indexPath.row]
            cell.configure(with: cateogry)
            
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddNewCategoryCell.registerId, for: indexPath) as? AddNewCategoryCell else { return UICollectionViewCell() }
            return cell
        default:
            return UICollectionViewCell()
        }
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
        if indexPath.section == 1 {
            self.dummyCategory.append(CategoryData(title: "새로운 카테고리", count: 0))
            collectionView.reloadData()
            
            let inputAlertViewController = InputAlertViewController()
            inputAlertViewController.modalPresentationStyle = .overCurrentContext
            inputAlertViewController.onCancelTapped = {
                self.dummyCategory.removeLast()
                collectionView.reloadData()
            }
            inputAlertViewController.onCompletionTapped = { inputText in
                self.dummyCategory[self.dummyCategory.count-1].title = inputText
                collectionView.reloadData()
            }
            present(inputAlertViewController, animated: false)
            
        }
    }
}
