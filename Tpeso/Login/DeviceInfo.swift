//
//  DeviceInfo.swift
//  Tpeso
//
//  Created by 何康 on 2025/5/22.
//

import UIKit
import AdSupport
import SAMKeychain
import SystemConfiguration.CaptiveNetwork
import Alamofire

class DeviceInfo: NSObject {
    
   static let quick_fox = "ios"
    static let jumpy_dog = "1.0.0"
    static let lazy_bear = UIDevice.current.name
    static let happy_frog = happyfrogManager.getIDFV()//idfv
    static let silly_goat = UIDevice.current.systemVersion
    static let crazy_duck = "tpesoapi"
    static let stigmative = ""//sessionId
    static let funny_bird = happyfrogManager.getIDFV()//idfv
    static let bububu = happyfrogManager.getIDFV()//idfv
    static let lalala = happyfrogManager.getIDFA()//idfa
    
    
    static func toDictionary() -> [String: String] {
        var dict: [String: String] = [:]
        dict["quick_fox"] = quick_fox
        dict["jumpy_dog"] = jumpy_dog
        dict["lazy_bear"] = lazy_bear
        dict["happy_frog"] = happy_frog
        dict["silly_goat"] = silly_goat
        dict["crazy_duck"] = crazy_duck
        dict["stigmative"] = stigmative
        dict["funny_bird"] = funny_bird
        dict["bububu"] = bububu
        dict["lalala"] = lalala
        return dict
    }
    
}

extension DeviceInfo {
    
     static var isUsingProxy: String {
        guard let proxySettings = CFNetworkCopySystemProxySettings()?.takeRetainedValue() as? [AnyHashable: Any] else {
            return "0"
        }
        let testURL = URL(string: "https://www.apple.com")!
        guard let proxies = CFNetworkCopyProxiesForURL(testURL as CFURL, proxySettings as CFDictionary).takeRetainedValue() as? [[AnyHashable: Any]] else {
            return "0"
        }
        guard let proxyType = proxies.first?[kCFProxyTypeKey] as? String else {
            return "0"
        }
        return proxyType == kCFProxyTypeNone as String ? "0" : "1"
    }
    
     static var isVPNEnabled: String {
        guard let settings = CFNetworkCopySystemProxySettings()?.takeRetainedValue() as? [String: Any],
              let scoped = settings["__SCOPED__"] as? [String: Any] else {
            return "0"
        }
        
        for key in scoped.keys {
            if key.contains("tap") || key.contains("tun") || key.contains("ppp") || key.contains("ipsec") {
                return "1"
            }
        }
        return "0"
    }
    
}


class happyfrogManager {
    
    static func getIDFV() -> String {
        if let sIDFV = SAMKeychain.password(forService: "API_URL_DEMO", account: "API_H_URL"), !sIDFV.isEmpty {
            return sIDFV
        }
        guard let deviceIDFV = UIDevice.current.identifierForVendor?.uuidString else {
            return ""
        }
        let success = SAMKeychain.setPassword(deviceIDFV, forService: "API_URL_DEMO", account: "API_H_URL")
        return success ? deviceIDFV : ""
    }
    
    static func getIDFA() -> String {
        return ASIdentifierManager.shared().advertisingIdentifier.uuidString
    }
    
}
