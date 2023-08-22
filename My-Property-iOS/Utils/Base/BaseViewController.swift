//
//  BaseViewController.swift
//  My-Property-iOS
//
//  Created by Ngoun Lyborey on 10/6/23.
//

import UIKit

class BaseVC: UIViewController {
    
    var didDismiss: (()->Void)?
    
    var needBackButton: Bool { return true }
    
    var navTitle: String? {
        didSet {
            if #available(iOS 15.0, *) {
                let label = UILabel()
//                label.font = UIFont.H6_16B
                label.textColor = UIColor.black
                label.text = navTitle
                navigationItem.titleView = label
            } else {
                let attributes = [
//                    NSAttributedString.Key.font: UIFont.H6_16B,
                    NSAttributedString.Key.foregroundColor: UIColor.white
                ]
                navigationController?.navigationBar.titleTextAttributes = attributes
                navigationItem.title = navTitle
            }
        }
    }
    
    override func viewDidLoad() {
        setNavSeparateLine()
        setupNavigationController()
    }
    
    private func setNavSeparateLine() {
        navigationController?.navigationBar.shadowImage = as1ptImage() /// set navigation bottom separator line color
        navigationController?.navigationBar.shadowImage = as1ptImage() /// set navigation bottom separator line color
//        navigationController?.navigationBar.setValue(!isNeedSeperateLine, forKey: "hidesShadow") /// hide or show navigation bottom separator line
    }
    
    func as1ptImage() -> UIImage? {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        let ctx = UIGraphicsGetCurrentContext()
//        self.setFill()
        ctx!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    private func setupNavigationController() {
        let leftItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left")?.withRenderingMode(.alwaysTemplate),
                                       style: .plain,
                                       target: self,
                                       action: #selector(tapBackButton))
        leftItem.tintColor = UIColor.black
        
        let navBar = navigationController?.navigationBar
        navBar?.backgroundColor = UIColor.black
        navBar?.barTintColor = UIColor.red
        
//        if hideNavSeparator {
//            navBar?.isTranslucent = false
//        }
//
//        if !isNeedNavTitle {
//            navigationItem.titleView = UIView()
//        }
        
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor.white
            
            //MARK: - set navigation bottom separator line color
//            appearance.shadowImage = bottomNavigationSeperateLineColor.as1ptImage()
            
            appearance.titleTextAttributes = [
//                NSAttributedString.Key.font: UIFont.H6_16B,
                NSAttributedString.Key.foregroundColor: UIColor.black
            ]
            
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }
        
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = needBackButton ? leftItem : nil
        navigationItem.title = navTitle
        extendedLayoutIncludesOpaqueBars = true // prevent animation glitch after push to VC with search bar
    }
    
    @objc func tapBackButton(){
        back(didDismiss)
    }
    
    @objc func back(_ completion: (()->Void)? = nil){
        if isModal {
            dismiss(animated: true, completion: completion)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    var isModal: Bool {
        if let index = navigationController?.viewControllers.firstIndex(of: self), index > 0 {
            return false
        } else if presentingViewController != nil {
            return true
        } else if let navigationController = navigationController, navigationController.presentingViewController?.presentedViewController == navigationController {
            return true
        } else if let tabBarController = tabBarController, tabBarController.presentingViewController is UITabBarController {
            return true
        } else {
            return false
        }
    }
}
