//
//  OnboardingViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/05.
//

import UIKit

struct OnboardingPage {
    let title: String
    let image: String
}

class OnboardingViewController: BaseViewController {
    let onboardingPages = [
        OnboardingPage(title: "일정에 여러 장소를 추가해 보세요", image: "markedRecordTest"),
        OnboardingPage(title: "내 일정을 기반으로 하루를 기록해 보세요", image: "markedRecordTest"),
        OnboardingPage(title: "지도로 내 기록을 한 눈에 볼 수 있어요", image: "markedRecordTest")
    ]
    
    private let onboardingLabel = UILabel()
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.register(OnboardingCell.self, forCellWithReuseIdentifier: OnboardingCell.registerId)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    private let pageControl = UIPageControl()
    private let startButton = UIButton()
    
    private var currentPage: Int = 0
    
    override func setupProperty() {
        super.setupProperty()
    
        onboardingLabel.setTextWithLineHeight(text: "일정에 여러 장소를 추가해 보세요", lineHeight: UILabel.title01)
        onboardingLabel.textColor = .color1C1C1C
        onboardingLabel.font = .title01
        
        pageControl.numberOfPages = onboardingPages.count
        pageControl.currentPage = currentPage
        pageControl.setCurrentPageIndicatorImage(UIImage(named: "currentPageIndicator"), forPage: currentPage)
        pageControl.preferredIndicatorImage = UIImage(named: "pageIndicator")
        pageControl.pageIndicatorTintColor = .colorC9C6C2
        pageControl.currentPageIndicatorTintColor = .color2EBD3D
        pageControl.isUserInteractionEnabled = false
        
        startButton.setTextWithLineHeight(text: "시작하기", lineHeight: 23.87)
        startButton.titleLabel?.font = .pretendard(.regular, size: 20)
        startButton.titleLabel?.textColor = .colorFFFFFF
        startButton.backgroundColor = .color9B9791
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(onboardingLabel)
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        view.addSubview(startButton)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        onboardingLabel.snp.makeConstraints {
            $0.top.equalTo(view).offset(112)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(onboardingLabel.snp.bottom).offset(46)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(pageControl.snp.top).offset(-56)
        }
        
        pageControl.snp.makeConstraints {
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(startButton.snp.top).offset(-39)
        }
        
        startButton.snp.makeConstraints {
            $0.leading.bottom.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(94)
        }
    }
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return onboardingPages.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCell.registerId, for: indexPath) as? OnboardingCell else { return UICollectionViewCell() }
        
        let image = onboardingPages[indexPath.row].image
        
        cell.configure(with: image)
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.bounds.width
        let height: CGFloat = collectionView.bounds.height
        return CGSize(width: width, height: height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        currentPage = Int(scrollView.contentOffset.x / scrollView.frame.width)
        self.pageControl.currentPage = currentPage
    }
}
