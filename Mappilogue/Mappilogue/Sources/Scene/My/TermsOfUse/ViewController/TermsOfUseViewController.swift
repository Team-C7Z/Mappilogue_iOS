//
//  TermsOfUseViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/09/03.
//

import UIKit
import WebKit

class TermsOfUseViewController: NavigationBarViewController {
    weak var coordinator: TermsOfUseCoordinator?
    var viewModel = TermsOfUseViewModel()
    
    private let webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        getTermsOfUserURL()
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        setPopBar(title: "이용약관")
        
        popBar.onPopButtonTapped = { [weak self] in
            guard let self = self else { return }
            
            coordinator?.popViewController()
        }
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
     
        view.addSubview(webView)
    }
    
    override func setupLayout() {
        super.setupLayout()

        webView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(98)
            $0.leading.bottom.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func openWebView(url: String) {
        guard let url = URL(string: url) else { return }
        
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    func getTermsOfUserURL() {
        viewModel.getTermsOfUse()
        
        viewModel.$termsOfUserResult
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { result in
                guard let result else { return }
                self.handleTermsOfUserResponse(result)
            })
            .store(in: &viewModel.cancellables)
    }
    
    func handleTermsOfUserResponse(_ response: Any) {
        guard let baseResponse = response as? BaseDTO<TermsOfUserDTO>, let result = baseResponse.result else { return }
        
        let url = result.link
        self.openWebView(url: url)
    }
}
