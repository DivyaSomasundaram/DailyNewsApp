//
//  AppCoordinator.swift
//  DailyNewsApp
//
//  Created by MobiloApps on 12/03/22.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController : UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.navigationBar.backgroundColor = .clear
    }
    
    override func start() {
       goToNewsList()
    }
    
    func goToNewsList() {
        let newsListViewController = NewsListViewController()
        let newsListViewModel = NewsListViewModel()
        newsListViewModel.coordinator = self
        newsListViewController.viewModel = newsListViewModel
        navigationController.setViewControllers([newsListViewController], animated: true)
    }
    
    func getSideMenuViewController() -> UIViewController {
        let newsCategoryListViewController = NewsCategoryViewController()
        let newsCategoryViewModel = NewsCategoryViewModel()
        newsCategoryListViewController.viewModel = newsCategoryViewModel
        let newsCategoryNavigationContrller = UINavigationController(rootViewController: newsCategoryListViewController)
        self.navigationController.navigationBar.backgroundColor = .white
        return newsCategoryNavigationContrller
    }
}
