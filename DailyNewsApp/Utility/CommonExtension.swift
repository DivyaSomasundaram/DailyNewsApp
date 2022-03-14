//
//  CommonExtension.swift
//  DailyNewsApp
//
//  Created by Divya Dinesh on 4/09/21.
//

import Foundation
import UIKit

fileprivate let activityIndicator = UIActivityIndicatorView.init(style: .large)
fileprivate let loadingLabel = UILabel.init()
fileprivate let loadingView = UIView.init()

///Common extension for UiViewController
extension UIViewController {
    
    /// To get topview controller of application
    /// - Returns: UIViewController
    class func topViewController() -> UIViewController? {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        var topController: UIViewController? = window?.rootViewController
        while topController?.presentedViewController != nil {
            topController = topController?.presentedViewController
        }
        return topController
    }
    
    /// Display alert merssage
    /// - Parameters:
    ///   - title: Alert title
    ///   - message: Alert Message
    ///   - style: Alert style
    ///   - actions: Alert actions
    ///   - barButtonItem: bar button item to present alert in ipad.
    func showAlertMessage(title: String? = "", message: String? = "", style: UIAlertController.Style = .alert, actions: [UIAlertAction]? = [UIAlertAction.init(title: "Ok", style: .cancel, handler: nil)] , barButtonItem: UIBarButtonItem? = nil) {
        DispatchQueue.main.async {[weak self] in
            let alertVC = UIAlertController.init(title: title, message: message, preferredStyle: style)
            if let alertAction = actions {
                for action in alertAction {
                    alertVC.addAction(action)
                }
            }
            alertVC.popoverPresentationController?.sourceView = self?.view
            if let barButton = barButtonItem {
                alertVC.popoverPresentationController?.barButtonItem = barButton
            }
            UIViewController.topViewController()?.present(alertVC, animated: true, completion: nil)
        }
    }
    
    /// Show loader for network or DB calls.
    func showLoader(_ loadingText: String? = NSLocalizedString("LOADING", comment: "")) {
        DispatchQueue.main.async {[weak self] in
            guard let weakSelf = self else { return }
            // Loading View to mask the current view and its actions.
            loadingView.translatesAutoresizingMaskIntoConstraints = false
            loadingView.backgroundColor = UIColor.init(white: 0, alpha: 0.5)
            activityIndicator.center = weakSelf.view.center
            activityIndicator.color = .white
            
            //Loading text to give more info to user.
            loadingLabel.translatesAutoresizingMaskIntoConstraints = false
            loadingLabel.text = loadingText ?? NSLocalizedString("LOADING", comment: "") 
            loadingLabel.textColor = .white
            loadingLabel.textAlignment = .center
            loadingLabel.font = UIFont.systemFont(ofSize: 16)
            
            loadingView.addSubview(loadingLabel)
            loadingView.addSubview(activityIndicator)
            weakSelf.view.addSubview(loadingView)
            
            loadingView.leadingAnchor.constraint(equalTo: weakSelf.view.leadingAnchor).isActive = true
            loadingView.trailingAnchor.constraint(equalTo: weakSelf.view.trailingAnchor).isActive = true
            loadingView.topAnchor.constraint(equalTo: weakSelf.view.topAnchor).isActive = true
            loadingView.bottomAnchor.constraint(equalTo: weakSelf.view.bottomAnchor).isActive = true
            
            loadingLabel.centerXAnchor.constraint(equalTo: weakSelf.view.centerXAnchor).isActive = true
            loadingLabel.centerYAnchor.constraint(equalTo: weakSelf.view.centerYAnchor, constant: 40).isActive = true

            weakSelf.view.bringSubviewToFront(loadingView)
            activityIndicator.startAnimating()
        }
    }
    
    /// Hide Loader.
    func hideLoader() {
        loadingView.isHidden = true
        loadingLabel.isHidden = true
        activityIndicator.stopAnimating()
    }
}
