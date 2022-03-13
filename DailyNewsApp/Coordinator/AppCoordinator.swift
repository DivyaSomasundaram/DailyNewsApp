//
//  AppCoordinator.swift
//  DailyNewsApp
//
//  Created by MobiloApps on 12/03/22.
//

import Foundation
import UIKit

/// Handles app naviagtion between pages/ screens.
class AppCoordinator: Coordinator {
    var window: UIWindow?
    
    override func start() {
       goToNewsList()
    }
    
    /// Navigation to News list View Controller.
    func goToNewsList() {
        let newsListViewController = NewsListViewController()
        let newsListViewModel = NewsListViewModel()
        newsListViewModel.coordinator = self
        newsListViewController.viewModel = newsListViewModel
        let navigationController = UINavigationController(rootViewController: newsListViewController)
        window?.rootViewController = navigationController
    }
}
