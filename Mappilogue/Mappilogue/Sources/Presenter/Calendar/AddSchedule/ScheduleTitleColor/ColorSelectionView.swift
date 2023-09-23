//
//  ColorSelectionView.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/28.
//

import UIKit

class ColorSelectionView: BaseView {
    private var colorList: [ColorListDTO] = []
    private var selectedColorId = 0
    var onSelectedColor: ((Int) -> Void)?
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .colorF9F8F7
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(ColorCell.self, forCellWithReuseIdentifier: ColorCell.registerId)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isUserInteractionEnabled = true
       
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        backgroundColor = .colorF9F8F7
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()

        self.addSubview(collectionView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(self)
        }
    }
    
    func configure(_ selectedColorId: Int, colorList: [ColorListDTO]) {
        self.selectedColorId = selectedColorId
        self.colorList = colorList
        
        collectionView.reloadData()
    }
}

extension ColorSelectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorCell.registerId, for: indexPath) as? ColorCell else { return UICollectionViewCell() }
        
        let color = colorList[indexPath.row]
        let isColorSelected = color.id == selectedColorId
        let colorCode = UIColor.fromHex(color.code)
        cell.configure(with: colorCode, isColorSelected: isColorSelected)
        cell.isUserInteractionEnabled = true
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 32, height: 32)
    }

    // 수평 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 36
    }

    // 수직 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 18
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 27, left: 20, bottom: 27, right: 19)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedColorId = colorList[indexPath.row].id
        onSelectedColor?(selectedColorId)
        
        collectionView.reloadData()
    }
}
