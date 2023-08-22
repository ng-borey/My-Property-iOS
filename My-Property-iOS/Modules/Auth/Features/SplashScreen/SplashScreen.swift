//
//  SplashScreen.swift
//  My-Property-iOS
//
//  Created by Ngoun Lyborey on 8/6/23.
//

import UIKit

class SplashScreen: UIViewController {

    let sv = AuthServices()
    let user = UserHelper()
    override func viewDidLoad() {
        super.viewDidLoad()
//        let phoneLoginValue = ["phone": "+85593461502","password": "1111"]
//        guard let data = try? JSONEncoder().encode(phoneLoginValue) else {
//            print("Internal app encoding error: ", phoneLoginValue)
//            return
//        }
//        sv.onLogin(credential: data) { [self] result in
//            switch result {
//            case .success(let data):
//                user.token.values = data.accessToken
//                print("success: \(user.token.values)")
//
//            case .failure(let data):
//                print("error: \(data.msg)")
//            }
//        }
        let nav = UINavigationController(rootViewController: SBManager.getPropertyListingVC())
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            SceneDelegate.window?.rootViewController = nav
            SceneDelegate.window?.makeKeyAndVisible()
        }
        
    }
}
