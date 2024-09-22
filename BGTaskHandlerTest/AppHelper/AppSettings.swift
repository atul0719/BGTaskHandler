//
//  AppSettings.swift
//  HLS Taxi
//
//  Created by Nakul Sharma on 23/08/18.
//  Copyright © 2018 TecOrb Technologies Pvt. Ltd. All rights reserved.
//

import CoreFoundation
import UIKit
import SystemConfiguration
import CoreTelephony


class AppSettings {
    
    
    static let shared = AppSettings()
    fileprivate init() {}
    
    lazy var uuid = UUID().uuidString

    
    class var isConnectedToNetwork: Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)

        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
    }


//    var shouldAskToSetTouchID:Bool{
//        return BioMetricAuthenticator.canAuthenticate() && self.interestedInLoginWithTouchID && (!self.isLoginWithTouchIDEnable)
//    }
//
//    var shouldAskToLoginWithTouchID:Bool{
//        return BioMetricAuthenticator.canAuthenticate() && self.isLoginWithTouchIDEnable
//    }
    
    

    
    func proceedToLogin(completionBlock :(() -> Void)? = nil){
           let navigationController = AppStoryboard.Main.viewController(LoginNavigationController.self)
           AppDelegate.getAppDelegate().window?.rootViewController = navigationController
        guard let handler = completionBlock else{
            return
        }
           handler()
       }
   
   
    
    //==========User Avatar Image
   /*   func userAvatarImage(username:String) -> UIImage{
       if username.count < 2 {
        return UIImage(named:"profile_placeholder")!
                }else{
        let configuration = LetterAvatarBuilderConfiguration()

        configuration.username = (username.trimmingCharacters(in: .whitespaces).count == 0) ? "NA" : username.uppercased()
            configuration.lettersColor = appColor.appLightBlueColour
        configuration.singleLetter = false
        configuration.lettersFont = fonts.Roboto.semiBold.font(.xXLarge)
        configuration.backgroundColors = [UIColor.white,UIColor.white,UIColor.white,UIColor.white,UIColor.white,UIColor.white,UIColor.white,UIColor.white,UIColor.white,UIColor.white,UIColor.white,UIColor.white]
        return UIImage.makeLetterAvatar(withConfiguration: configuration) ?? UIImage(named:"profile_placeholder")!
            
    }
        
    }
*/

    
}





