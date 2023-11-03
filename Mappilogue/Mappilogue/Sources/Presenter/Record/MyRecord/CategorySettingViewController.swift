//
//  CategorySettingViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/03.
//

import UIKit

class CategorySettingViewController: BaseViewController {
    var dummyCategory: [Category] = []
    var selectedCateogry: [Bool] = []
    
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
        collectionView.dragDelegate = self
        collectionView.dropDelegate = self
       
        return collectionView
    }()

     override func viewDidLoad() {
         super.viewDidLoad()
         
         selectedCateogry = Array(repeating: false, count: dummyCategory.count)
     }
     
     override func setupProperty() {
         super.setupProperty()
         
         setNavigationTitleAndBackButton("카테고리 설정", backButtonAction: #selector(backButtonTapped))
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
            if indexPath.row <= dummyCategory.count {
                return configureCategoryOrderCell(for: indexPath, in: collectionView)
            } else {
                return configureAddNewCategoryCell(for: indexPath, in: collectionView)
            }
            
        case 1:
            if indexPath.row == 0 {
                return configureCategorySelectionLabelCell(for: indexPath, in: collectionView)
            } else {
                return configureCategorySelectionCell(for: indexPath, in: collectionView)
            }
        default:
            return UICollectionViewCell()
        }
    }
    
    private func configureCategoryOrderCell(for indexPath: IndexPath, in collectionView: UICollectionView) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryOrderCell.registerId, for: indexPath) as? CategoryOrderCell else {
            return UICollectionViewCell()
        }
        
        let totalCategory = Category(id: 0, title: "전체", isMarkInMap: "", markCount: 0)
        let isTotal = indexPath.row == 0
        let category = isTotal ? totalCategory : dummyCategory[indexPath.row - 1]
        cell.configure(with: category, isTotal: isTotal)

        return cell
    }
    
    private func configureAddNewCategoryCell(for indexPath: IndexPath, in collectionView: UICollectionView) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddNewCategoryCell.registerId, for: indexPath) as? AddNewCategoryCell else {
            return UICollectionViewCell()
        }
        return cell
    }
    
    private func configureCategorySelectionLabelCell(for indexPath: IndexPath, in collectionView: UICollectionView) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategorySelectionLabelCell.registerId, for: indexPath) as? CategorySelectionLabelCell else {
            return UICollectionViewCell()
        }
        return cell
    }

    private func configureCategorySelectionCell(for indexPath: IndexPath, in collectionView: UICollectionView) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategorySelectionCell.registerId, for: indexPath) as? CategorySelectionCell else {
            return UICollectionViewCell()
        }
        
        let categoryTitle = dummyCategory[indexPath.row-1].title
        let isSelection = selectedCateogry[indexPath.row-1]
        cell.configure(categoryTitle, isSelection: isSelection)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: section == 0 ? 24 : 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return CGSize(width: collectionView.frame.width - 32, height: 41)
        default:
            if indexPath.row == 0 {
                return CGSize(width: collectionView.frame.width - 32, height: 18)
            } else {
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
            presentInputAlertViewController()
        } else if indexPath.section == 1 && indexPath.row > 0 {
            if collectionView.cellForItem(at: indexPath) is CategorySelectionCell {
                selectedCateogry[indexPath.row-1] = !selectedCateogry[indexPath.row-1]
                collectionView.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, canHandle session: UIDropSession) -> Bool {
        return true
    }
    
    private func presentInputAlertViewController() {
        let inputAlertViewController = InputAlertViewController()
        inputAlertViewController.modalPresentationStyle = .overCurrentContext
        inputAlertViewController.onCompletionTapped = { inputText in
            self.addCategory(inputText)
        }
        present(inputAlertViewController, animated: false)
    }
    
    func addCategory(_ input: String) {
        dummyCategory.append(Category(id: 0, title: input, isMarkInMap: "", markCount: 0))
        selectedCateogry.append(false)
        collectionView.reloadData()
    }
    
    private func isIndexPathValid(_ indexPath: IndexPath) -> Bool {
        return indexPath.section == 0 && indexPath.row > 0 && indexPath.row <= dummyCategory.count
    }
}

extension CategorySettingViewController: UICollectionViewDragDelegate {
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        if isIndexPathValid(indexPath) {
            return [UIDragItem(itemProvider: NSItemProvider())]
        }
        return []
    }
}

extension CategorySettingViewController: UICollectionViewDropDelegate {
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        guard let indexPath = destinationIndexPath else {
            return UICollectionViewDropProposal(operation: .cancel, intent: .unspecified)
        }
        
        if session.localDragSession != nil, isIndexPathValid(indexPath) {
            return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
        
        return UICollectionViewDropProposal(operation: .cancel, intent: .unspecified)
    }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        guard let destinationIndexPath = coordinator.destinationIndexPath else {
            return
        }
        
        if isIndexPathValid(destinationIndexPath) {
            coordinator.items.forEach { dropItem in
                guard let sourceIndexPath = dropItem.sourceIndexPath else { return }
                let categoryCell = self.dummyCategory[sourceIndexPath.row-1]
                let selectedCell = self.selectedCateogry[sourceIndexPath.row-1]
                
                collectionView.performBatchUpdates({
                    collectionView.deleteItems(at: [sourceIndexPath])
                    collectionView.insertItems(at: [destinationIndexPath])
                    self.dummyCategory.remove(at: sourceIndexPath.row-1)
                    self.dummyCategory.insert(categoryCell, at: destinationIndexPath.row-1)
                    self.selectedCateogry.remove(at: sourceIndexPath.row-1)
                    self.selectedCateogry.insert(selectedCell, at: destinationIndexPath.row-1)
                }, completion: { _ in
                    coordinator.drop(dropItem.dragItem, toItemAt: destinationIndexPath)
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0) {
                        collectionView.reloadData()
                    }
                })
            }
        }
    }
}

class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        
        var leftMargin = sectionInset.left
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
