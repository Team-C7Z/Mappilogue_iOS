//
//  ModalNavigationRouter.swift
//  Mappilogue
//
//  Created by hyemi on 2/4/24.
//

import UIKit

public class ModalNavigationRouter: NSObject {
    public unowned let parentViewController: UIViewController
    
    private let navigationController = UINavigationController()
    private var onDismissForViewController: [UIViewController: (() -> Void)] = [:]
    
    public init(parentViewController: UIViewController) {
        self.parentViewController = parentViewController
        
        super.init()
        
        navigationController.delegate = self
    }
}

extension ModalNavigationRouter: Router {
    public func present(_ viewController: UIViewController, animated: Bool, onDismissed: (() -> Void)?) {
        onDismissForViewController[viewController] = onDismissed
        if navigationController.viewControllers.isEmpty {
            presentModally(viewController, animated: animated)
        } else {
            navigationController.pushViewController(viewController, animated: animated)
        }
    }
    
    private func presentModally(_ viewController: UIViewController, animated: Bool) {
        navigationController.setViewControllers([viewController], animated: false)
        navigationController.modalPresentationStyle = .overFullScreen
        parentViewController.present(navigationController, animated: animated, completion: nil)
    }

    public func dismiss(animated: Bool) {
        performOnDismissed(for: navigationController.viewControllers.first!)
        parentViewController.dismiss(animated: animated, completion: nil)
    }
    
    private func performOnDismissed(for viewController: UIViewController) {
        guard let onDismiss = onDismissForViewController[viewController] else { return }
        onDismiss()
        onDismissForViewController[viewController] = nil
    }
}

extension ModalNavigationRouter: UINavigationControllerDelegate {
    
    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
        guard let dismissedViewController = navigationController.transitionCoordinator?.viewController(forKey: .from),
              !navigationController.viewControllers.contains(dismissedViewController) else {
            return
        }
        
        performOnDismissed(for: dismissedViewController)
    }
}
