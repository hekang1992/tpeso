//
//  NetworkManager.swift
//  TPeso
//
//  Created by tom on 2025/1/21.
//


import Alamofire
import FBSDKCoreKit
import AppTrackingTransparency
import Combine

class NetworkManager {
    
    var cancellables = Set<AnyCancellable>()
    
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
        let man = NetworkRequest()
        let dirty_floor = happyfrogManager.getIDFV()//idfv
        let neat_desk = happyfrogManager.getIDFA()//idfa
        let dict = ["dirty_floor": dirty_floor, "neat_desk": neat_desk]
        let result =  man.postRequest(url: "/tplink/pere", parameters: dict, contentType: .json).sink { _ in
            
        } receiveValue: { [weak self] data in
            guard let self = self else { return }
            do {
                let model = try JSONDecoder().decode(BaseModel.self, from: data)
                let invalidValues: Set<String> = ["0", "00"]
                if invalidValues.contains(model.laminacy) {
                    Settings.shared.appID = model.raceast?.rubrative?.whoseive ?? ""
                    Settings.shared.clientToken = model.raceast?.rubrative?.quiship ?? ""
                    Settings.shared.displayName = model.raceast?.rubrative?.corticoence ?? ""
                    Settings.shared.appURLSchemeSuffix = model.raceast?.rubrative?.gardenitude ?? ""
                    ApplicationDelegate.shared.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)
                }
            } catch  {
                print("JSON: \(error)")
            }
        }
        result.store(in: &cancellables)
    }
    
}
