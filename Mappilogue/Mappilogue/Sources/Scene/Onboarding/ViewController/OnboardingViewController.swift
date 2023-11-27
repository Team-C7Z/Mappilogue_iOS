//
//  OnboardingViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/05.
//

import UIKit

class OnboardingViewController: BaseViewController {
    private let onboardingPages = [
        Onboarding(title: "일정에 여러 장소를 추가해 보세요", image: "onboarding1"),
        Onboarding(title: "내 일정을 기반으로 하루를 기록해 보세요", image: "onboarding2"),
        Onboarding(title: "지도로 내 기록을 한 눈에 볼 수 있어요", image: "onboarding3")
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
    private let startButtonLabel = UILabel()
    
    private var currentPage: Int = 0
    
    override func setupProperty() {
        super.setupProperty()
    
        onboardingLabel.text = "일정에 여러 장소를 추가해 보세요"
        onboardingLabel.textColor = .color1C1C1C
        onboardingLabel.font = .title01
        
        pageControl.numberOfPages = onboardingPages.count
        pageControl.currentPage = currentPage
        pageControl.setCurrentPageIndicatorImage(UIImage(named: "currentPageIndicator"), forPage: currentPage)
        pageControl.preferredIndicatorImage = UIImage(named: "pageIndicator")
        pageControl.pageIndicatorTintColor = .colorC9C6C2
        pageControl.currentPageIndicatorTintColor = .color2EBD3D
        pageControl.isUserInteractionEnabled = false
    
        startButton.backgroundColor = .color9B9791
        startButton.layer.cornerRadius = 12
        startButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        startButtonLabel.text = "시작하기"
        startButtonLabel.textColor = .colorFFFFFF
        startButtonLabel.font = .subtitle01
        startButton.isEnabled = false
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(onboardingLabel)
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        view.addSubview(startButton)
        startButton.addSubview(startButtonLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        onboardingLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(48)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(onboardingLabel.snp.bottom).offset(71)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(pageControl.snp.top).offset(-39)
        }
        
        pageControl.snp.makeConstraints {
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(startButton.snp.top).offset(-39)
        }
        
        startButton.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(94)
        }
        
        startButtonLabel.snp.makeConstraints {
            $0.top.equalTo(startButton).offset(28)
            $0.centerX.equalTo(startButton)
        }
    }
    
    @objc private func startButtonTapped(_ sender: UIButton) {
        RootUserDefaults.setOnboardingComplete()
        
        let logInViewController = LoginViewController()
        logInViewController.modalPresentationStyle = .fullScreen
        present(logInViewController, animated: false)
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
        pageControl.currentPage = currentPage
        onboardingLabel.text = onboardingPages[currentPage].title
        
        if currentPage < (onboardingPages.count - 1) {
            startButton.backgroundColor = .color9B9791
            startButton.isEnabled = false
        } else {
            startButton.backgroundColor = .color1C1C1C
            startButton.isEnabled = true
        }
    }
}
