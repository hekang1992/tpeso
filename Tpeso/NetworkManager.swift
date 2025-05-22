//
//  NetworkManager.swift
//  PesoPitaka
//
//  Created by Benjamin on 2025/1/21.
//


import Alamofire
import FBSDKCoreKit
import AppTrackingTransparency

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private var reachaManager: NetworkReachabilityManager?
    
    private init() {
        self.reachaManager = NetworkReachabilityManager()
    }
    
    func startListening() {
        self.reachaManager?.startListening(onUpdatePerforming: { status in
            switch status {
            case .notReachable:
                break
            case .reachable(.ethernetOrWiFi):
                self.degeinfo()
                break
            case .reachable(.cellular):
                self.degeinfo()
                break
            case .unknown:
                break
            }
        })
    }
    
    func stopListening() {
        self.reachaManager?.stopListening()
    }
    
    func degeinfo() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.45) {
            if #available(iOS 14.0, *) {
                ATTrackingManager.requestTrackingAuthorization { status in
                    switch status {
                    case .restricted:
                        break
                    case .authorized, .notDetermined, .denied:
                        self.getIDFAInfo()
                        break
                    @unknown default:
                        break
                    }
                }
            }
        }
    }
    
    private func getIDFAInfo() {
        
    }
    
//    private func thridToUfc(from model: thirdModel) {
//        Settings.shared.appID = model.coincidentally ?? ""
//        Settings.shared.clientToken = model.hands ?? ""
//        Settings.shared.displayName = model.passing ?? ""
//        Settings.shared.appURLSchemeSuffix = model.met ?? ""
//        ApplicationDelegate.shared.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)
//    }

}
