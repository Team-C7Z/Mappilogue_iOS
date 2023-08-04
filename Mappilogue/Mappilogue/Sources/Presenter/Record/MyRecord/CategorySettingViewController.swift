//
//  CategorySettingViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/03.
//

import UIKit

class CategorySettingViewController: BaseViewController {
    var dummyCategory = dummyCategoryData()
    
    private lazy var collectionView: UICollectionView = {
        let layout = LeftAlignedCollectionViewFlowLayout()

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .colorF9F8F7
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
        collectionView.register(CategoryOrderCell.self, forCellWithReuseIdentifier: CategoryOrderCell.registerId)
        collectionView.register(AddNewCategoryCell.self, forCellWithReuseIdentifier: AddNewCategoryCell.registerId)
        collectionView.register(CategorySelectionLabelCell.self, forCellWithReuseIdentifier: CategorySelectionLabelCell.registerId)
        collectionView.register(CategorySelectionCell.self, forCellWithReuseIdentifier: CategorySelectionCell.registerId)
        collectionView.delegate = self
        collectionView.dataSource = self
       
        return collectionView
    }()

     override func viewDidLoad() {
         super.viewDidLoad()
         
     }
     
     override func setupProperty() {
         super.setupProperty()
         
         setNavigationBar("카테고리 설정", backButtonAction: #selector(backButtonTapped))
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

extension CategorySettingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return dummyCategory.count + 2
        case 1:
            return dummyCategory.count + 1
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0...dummyCategory.count:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryOrderCell.registerId, for: indexPath) as? CategoryOrderCell else { return UICollectionViewCell() }
                
                let totalCateogry = CategoryData(title: "전체", count: dummyCategory.map {$0.count}.reduce(0, +))
                let category = indexPath.row == 0 ? totalCateogry : dummyCategory[indexPath.row - 1]
                cell.configure(with: category)

                return cell
            default:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddNewCategoryCell.registerId, for: indexPath) as? AddNewCategoryCell else { return UICollectionViewCell() }
                return cell
            }
         
        case 1:
            switch indexPath.row {
            case 0:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategorySelectionLabelCell.registerId, for: indexPath) as? CategorySelectionLabelCell else { return UICollectionViewCell() }
                return cell
            default:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategorySelectionCell.registerId, for: indexPath) as? CategorySelectionCell else { return UICollectionViewCell() }
                
                let categoryTitle = dummyCategory[indexPath.row-1].title
                cell.configure(categoryTitle, isSelection: false)
                
                return cell
            }
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: section == 0 ? 24 : 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return CGSize(width: collectionView.frame.width - 32, height: 41)
        default:
            switch indexPath.row {
            case 0:
                return CGSize(width: collectionView.frame.width - 32, height: 18)
            default:
                let cateogoryTitle = dummyCategory[indexPath.row-1].title
                return CGSize(width: cateogoryTitle.size(withAttributes: [NSAttributedString.Key.font: UIFont.caption02]).width + 12 + 28, height: 32)
            }
        }
    }

    // 수평 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return section == 0 ? 0 : 12
    }

    // 수직 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return section == 0 ? 0 : 12
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == dummyCategory.count + 1 {
            let inputAlertViewController = InputAlertViewController()
            inputAlertViewController.modalPresentationStyle = .overCurrentContext
            inputAlertViewController.onCompletionTapped = { inputText in
                self.dummyCategory.append(CategoryData(title: inputText, count: 0))
                self.collectionView.reloadData()
            }
            present(inputAlertViewController, animated: false)
        }
    }
    
}

class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        
        var leftMargin = sectionInset.left //
        var maxY: CGFloat = -1.0
        attributes?.forEach { layoutAttribute in
            if layoutAttribute.representedElementKind == nil {
                if layoutAttribute.frame.origin.y >= maxY {
                    leftMargin = sectionInset.left
                }
                
                layoutAttribute.frame.origin.x = leftMargin
                
                leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
                maxY = max(layoutAttribute.frame.maxY, maxY)
            }
        }
        return attributes
    }
}
