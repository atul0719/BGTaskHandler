//
//  UIViewController.swift
//  BGTaskHandlerTest
//
//  Created by Atul on 08/08/24.
//

import Foundation
import UIKit

extension UIViewController {

    class var storyboardID : String {
        return "\(self)"
    }
    static func instantiate(fromAppStoryboard appStoryboard : AppStoryboard) -> Self {
        return appStoryboard.viewController(self)
    }
}


enum AppStoryboard : String {

    case Main
   // case SpecialistDashboard, SpecialistProfile, Tracker, SpecialistMain, Help, SpecialistChat

    var instance : UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }

    func viewController<T : UIViewController>(_ viewControllerClass : T.Type) -> T {
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        return instance.instantiateViewController(withIdentifier: storyboardID) as! T
    }

    func initialViewController() -> UIViewController? {
        return instance.instantiateInitialViewController()
    }
}
