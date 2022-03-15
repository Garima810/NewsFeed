//
//  NewsCoordinator.swift
//  NewsItem
//
//  Created by Garima Ashish Bisht on 13/03/22.
//

import UIKit


class NewsCoordinator: NSObject, UINavigationBarDelegate, UINavigationControllerDelegate {
    
    private var navigationController = UINavigationController()

    private var viewModel = NewsViewModel()

    // MARK: - Public API
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {}
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {}
    
    var rootViewController: UIViewController {
        return navigationController
    }
    
    // MARK: - Setup
    private func setupRootViewController(with viewController: UIViewController) {
        navigationController = UINavigationController(rootViewController: viewController)
        navigationController.delegate = self
    }
    
    private func newsViewController() -> UIViewController {
        let newsViewController = NewsViewController(viewModel: viewModel)
        return newsViewController
    }
    
    func start() {
//        setupRootViewController(with: newsViewController())
        let newsViewController = NewsViewController(viewModel: viewModel)
        self.navigationController.pushViewController(newsViewController, animated: true)
    }

}
