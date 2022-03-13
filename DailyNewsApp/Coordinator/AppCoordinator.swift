//
//  AppCoordinator.swift
//  DailyNewsApp
//
//  Created by MobiloApps on 12/03/22.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    var window: UIWindow?
    
    override func start() {
       goToNewsList()
    }
    
    func goToNewsList() {
        let newsListViewController = NewsListViewController()
        let newsListViewModel = NewsListViewModel()
        newsListViewModel.coordinator = self
        newsListViewController.viewModel = newsListViewModel
        let navigationController = UINavigationController(rootViewController: newsListViewController)
        window?.rootViewController = navigationController
    }
}
