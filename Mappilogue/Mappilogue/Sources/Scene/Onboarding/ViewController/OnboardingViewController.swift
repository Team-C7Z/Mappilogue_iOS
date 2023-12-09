//
//  OnboardingViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/05.
//

import UIKit
import MappilogueKit

class OnboardingViewController: BaseViewController {
    var viewModel = OnboardingViewModel()
    
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
    
    override func setupProperty() {
        super.setupProperty()
    
        onboardingLabel.text = "일정에 여러 장소를 추가해 보세요"
        onboardingLabel.textColor = .black1C1C1C
        onboardingLabel.font = .title01
        
        pageControl.numberOfPages = viewModel.onboardingPages.count
        pageControl.currentPage = viewModel.currentPage
        pageControl.setCurrentPageIndicatorImage(Images.image(named: .imageOnboardingCurrentPage), forPage: viewModel.currentPage)
        pageControl.preferredIndicatorImage = Images.image(named: .imageOnboardingPage)
        pageControl.pageIndicatorTintColor = .grayC9C6C2
        pageControl.currentPageIndicatorTintColor = .green2EBD3D
        pageControl.isUserInteractionEnabled = false
    
        startButton.backgroundColor = .gray9B9791
        startButton.layer.cornerRadius = 12
        startButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        startButtonLabel.text = "시작하기"
        startButtonLabel.textColor = .whiteFFFFFF
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
        return viewModel.onboardingPages.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCell.registerId, for: indexPath) as? OnboardingCell else { return UICollectionViewCell() }
        
        let image = viewModel.onboardingPages[indexPath.row].image
        
        cell.configure(with: image)
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.bounds.width
        let height: CGFloat = collectionView.bounds.height
        return CGSize(width: width, height: height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updatePageDesign(Int(scrollView.contentOffset.x / scrollView.frame.width))
    }
    
    private func updatePageDesign(_ page: Int) {
        viewModel.currentPage = page
        pageControl.currentPage = page
        onboardingLabel.text = viewModel.onboardingPages[ page].title
        
        if viewModel.setStartButton() {
            startButton.backgroundColor = .black1C1C1C
            startButton.isEnabled = true
        } else {
            startButton.backgroundColor = .gray9B9791
            startButton.isEnabled = false
        }
    }
}
