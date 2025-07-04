//
//  AppDelegate.swift
//  Tpeso
//
//  Created by tom on 2025/5/19.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared.isEnabled = true
        IQKeyboardManager.shared.resignOnTouchOutside = true
        window = UIWindow()
        window?.frame = UIScreen.main.bounds
        let isClick = UserDefaults.standard.object(forKey: "GUIDECLICK") as? String ?? ""
        if isClick == "1" {
            getRootVc()
        }else {
            window?.rootViewController = GuideViewController()
        }
        NetworkManager.shared.startListening()
        window?.makeKeyAndVisible()
        return true
    }

}

extension AppDelegate {
    
    private func getRootVc() {
        let byy = UserDefaults.standard.object(forKey: "byy") as? String ?? ""
        let xyz = UserDefaults.standard.object(forKey: "xyz") as? String ?? ""
        if IS_LOGIN {
            let webVc = WebViewController()
            let pageUrl =  URLQueryAppender.appendQueryParameters(to: xyz, parameters: DeviceInfo.toDictionary())!
            webVc.pageUrl = pageUrl
            
            self.window?.rootViewController = byy == "vcd" ? BaseNavigationController(rootViewController: webVc) : BaseNavigationController(rootViewController: HomeViewController())
        }else {
            self.window?.rootViewController = BaseNavigationController(rootViewController: LoginViewController())
        }
    }
    
}
