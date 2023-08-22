//
//  ViewController.swift
//  My-Property-iOS
//
//  Created by Ngoun Lyborey on 5/6/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let nav = UINavigationController(rootViewController: SBManager.getPropertyListingVC())
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.navigationController?.pushViewController(nav, animated: true)
        }
    }


}

