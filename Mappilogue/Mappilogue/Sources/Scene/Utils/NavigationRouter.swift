//
//  NavigationRouter.swift
//  Mappilogue
//
//  Created by hyemi on 2/4/24.
//

import UIKit

public class NavigationRouter: NSObject {
    private let navigationController: UINavigationController
    private let routerRootController: UIViewController?
    private var onDismissForViewController: [UIViewController: (() -> Void)] = [:]
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.routerRootController = navigationController.viewControllers.first
        
        super.init()
        print(navigationController.viewControllers, 8766)
        navigationController.delegate = self
    }
}

extension NavigationRouter: Router {
    public func present(_ viewController: UIViewController, animated: Bool, onDismissed: (() -> Void)?) {
        // dismiss closure 등록
        onDismissForViewController[viewController] = onDismissed
        navigationController.pushViewController(viewController, animated: animated)
    }
    
    // dismiss 시키기
    public func dismiss(animated: Bool) {
        
        if let routerRootController = routerRootController {
            print(111)
            performOnDismissed(for: routerRootController)
            navigationController.popToViewController(routerRootController, animated: animated)
        }
        print(222)
        navigationController.popToRootViewController(animated: animated)
    }
    
    // dismiss 액션 실행
    private func performOnDismissed(for viewController: UIViewController) {
        guard let onDismiss = onDismissForViewController[viewController] else {
            return
        }
        
        onDismiss()
        onDismissForViewController[viewController] = nil
    }
}

extension NavigationRouter: UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController,
                                     didShow viewController: UIViewController, animated: Bool) {
        guard let dismissedViewController = navigationController.transitionCoordinator?.viewController(forKey: .from),
              !navigationController.viewControllers.contains(dismissedViewController) else {
            return
        }
        
        performOnDismissed(for: dismissedViewController)
    }
}
