//
//  SBManager.swift
//  Membership
//
//  Created by Ngoun Lyborey on 26/5/23.
//

import Foundation
import UIKit

class SBManager {
    
    static func getSplashScreen() -> SplashScreen {
        let vc = UIStoryboard(name: SplashScreen.ID, bundle: nil).instantiateViewController(withIdentifier: SplashScreen.ID) as! SplashScreen
        return vc
    }
    
    static func getPropertyListingVC() -> PropertyListingVC {
        let vc = UIStoryboard(name: PropertyListingVC.ID, bundle: nil).instantiateViewController(withIdentifier: PropertyListingVC.ID) as! PropertyListingVC
        return vc
    }
    
    static func getCreatePropertyVC() -> CreatePropertyVC {
        let vc = UIStoryboard(name: CreatePropertyVC.ID, bundle: nil).instantiateViewController(withIdentifier: CreatePropertyVC.ID) as! CreatePropertyVC
        return vc
    }
    
    
    static func getPropertyTypeVC() -> PropteryTypeVC {
        let vc = UIStoryboard(name: PropteryTypeVC.ID, bundle: nil).instantiateViewController(withIdentifier: PropteryTypeVC.ID) as! PropteryTypeVC
        return vc
    }
}
