//
//  LoginInfo.swift
//  Tpeso
//
//  Created by tom on 2025/5/26.
//

import NetworkExtension
import SystemConfiguration.CaptiveNetwork
import MachO
import Foundation
import UIKit
import Alamofire
import DeviceKit

class LoginInfo {
    
   static func getDeviceInfoDictionary() -> [String: Any] {
        let wild_deer = "ios"
        let calm_lake = UIDevice.current.systemVersion
        let hot_sand = getLastTime()
        let cold_rain = Bundle.main.bundleIdentifier ?? ""
        
        let soft_wind = [
            "hard_rock": getBatteryInfoLevel(),
            "dark_night": getBatteryInfo()
        ]
        
        let bright_day = [
            "dirty_floor": happyfrogManager.getIDFV(),
            "neat_desk": happyfrogManager.getIDFA(),
            "long_road": getMacInfo(),
            "short_cut": currentTimestamp,
            "high_hill": DeviceInfo.isUsingProxy,
            "deep_pool": DeviceInfo.isVPNEnabled,
            "wide_river": DeviceInfo.isJailbroken,
            "gerence": String(isSimulator),
            "thin_line": Locale.preferredLanguages.first ?? "",
            "thick_book": "",
            "fast_car": wifiName,
            "slow_walk": NSTimeZone.system.abbreviation() ?? "",
            "old_tree": systemUptime
        ]
        
        let new_leaf = [
            "blue_sky": "",
            "red_rose": UIDevice.current.name,
            "green_tea": "",
            "black_coal": String(format: "%.0f", UIScreen.main.bounds.height),
            "brown_dirt": String(format: "%.0f", UIScreen.main.bounds.width),
            "white_milk": String(Device.identifier),
            "pink_flower": Device.current.description,
            "citegnortsa": UIDevice.current.model,
            "gray_stone": String(Device.current.diagonal),
            "pure_gold": UIDevice.current.systemVersion
        ]
        
        let dict = [
            "ag": LoginInfo.getWiFiIPAddress() ?? "",
            "salty_sea": LoginInfo.getMacInfo(),
            "long_road": LoginInfo.getMacInfo(),
            "spicy_food": LoginInfo.getWiFiIPAddress() ?? ""
        ]
        
        let sweet_cake: [String: Any] = [
            "sour_lemon": getWiFiIPBAddress() ?? "",
            "bitter_pill": [[
                "ag": LoginInfo.getWiFiIPAddress() ?? "",
                "salty_sea": LoginInfo.getMacInfo(),
                "long_road": LoginInfo.getMacInfo(),
                "spicy_food": LoginInfo.getWiFiIPAddress() ?? ""
            ]],
            "cold_ice": [
                "ag": LoginInfo.getWiFiIPAddress() ?? "",
                "salty_sea": LoginInfo.getMacInfo(),
                "long_road": LoginInfo.getMacInfo(),
                "spicy_food": LoginInfo.getWiFiIPAddress() ?? ""
            ],
            "hot_fire": "1"
        ]
        
        let dry_dust: [String: Any] = [
            "wet_water": getStorageUsage()?.free1 ?? "",
            "light_lamp": getStorageUsage()?.total1 ?? "",
            "heavy_box": getMemoryUsage()?.free ?? "",
            "open_door": getMemoryUsage()?.total ?? ""
        ]
        
        return [
            "wild_deer": wild_deer,
            "calm_lake": calm_lake,
            "hot_sand": hot_sand,
            "cold_rain": cold_rain,
            "soft_wind": soft_wind,
            "bright_day": bright_day,
            "new_leaf": new_leaf,
            "dict": dict,
            "sweet_cake": sweet_cake,
            "dry_dust": dry_dust
        ]
    }

    
    
}

extension LoginInfo {
    
    private static func getLastTime() -> String {
        let onetime = ProcessInfo.processInfo.systemUptime
        let loginDate = Date(timeIntervalSinceNow: -onetime)
        let time = String(format: "%ld", Int(loginDate.timeIntervalSince1970 * 1000))
        return time
    }
    
    private static func getBatteryInfoLevel() -> Int {
        UIDevice.current.isBatteryMonitoringEnabled = true
        let batteryLevel = Int(UIDevice.current.batteryLevel * 100)
        return batteryLevel
    }
    
    private static func getBatteryInfo() -> Int {
        UIDevice.current.isBatteryMonitoringEnabled = true
        let isCharging = UIDevice.current.batteryState == .charging ? 1 : 0
        return isCharging
    }
    
}

extension LoginInfo {
    
    static func getMacInfo() -> String {
        guard let inters = CNCopySupportedInterfaces() as? [String] else {
            return ""
        }
        for interface in inters {
            guard let networkInfo = CNCopyCurrentNetworkInfo(interface as CFString) as? [String: Any],
                  let bssid = networkInfo[kCNNetworkInfoKeyBSSID as String] as? String else {
                continue
            }
            return bssid
        }
        return ""
    }
    
    static func getWiFiIPAddress() -> String? {
        guard let interfaceNames = CNCopySupportedInterfaces() as? [String] else {
            return nil
        }
        for interfaceName in interfaceNames {
            if let networkInfo = CNCopyCurrentNetworkInfo(interfaceName as CFString) as? [String: Any] {
                if let ipAddress = networkInfo["SSID"] as? String {
                    return ipAddress
                }
            }
        }
        return nil
    }
    
    static func getWiFiIPBAddress() -> String? {
        var address: String?
        var ifaddr: UnsafeMutablePointer<ifaddrs>? = nil
        if getifaddrs(&ifaddr) == 0 {
            var ptr = ifaddr
            while ptr != nil {
                defer { ptr = ptr?.pointee.ifa_next }
                
                let interface = ptr?.pointee
                let addrFamily = interface?.ifa_addr.pointee.sa_family
                if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                    
                    let name = String(cString: (interface?.ifa_name)!)
                    if name == "en0" || name == "en1" {
                        
                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                        getnameinfo(interface?.ifa_addr, socklen_t((interface?.ifa_addr.pointee.sa_len)!),
                                    &hostname, socklen_t(hostname.count),
                                    nil, socklen_t(0), NI_NUMERICHOST)
                        address = String(cString: hostname)
                    }
                }
            }
            freeifaddrs(ifaddr)
        }
        return address
    }
    
     static var currentTimestamp: String {
        let currentTime = Date().timeIntervalSince1970
        return String(Int64(currentTime * 1000))
    }
    
    private static var isSimulator: Int {
#if targetEnvironment(simulator)
        return 1
#else
        return 0
#endif
    }
    
    private static var systemUptime: String {
        let systemUptime = ProcessInfo.processInfo.systemUptime
        return String(format: "%.0f", systemUptime * 1000)
    }
    
    private static var wifiName: String {
        let reachabilityManager = NetworkReachabilityManager()
        let status = reachabilityManager?.status
        switch status {
        case .notReachable:
            return "NONE"
        case .reachable(.cellular):
            return "5G/4G"
        case .reachable(.ethernetOrWiFi):
            return "WIFI"
        default:
            return "NONE"
        }
    }
    
    static func getStorageUsage() -> (used1: UInt64, free1: UInt64, total1: UInt64)? {
        let fileURL = URL(fileURLWithPath: NSHomeDirectory() as String)
        do {
            let values = try fileURL.resourceValues(forKeys: [.volumeAvailableCapacityKey, .volumeTotalCapacityKey])
            if let free = values.volumeAvailableCapacity, let total = values.volumeTotalCapacity {
                let used = total - free
                return (used1: UInt64(used), free1: UInt64(free), total1: UInt64(total))
            }
        } catch {
            print("Error: Failed to get storage usage - \(error)")
        }
        return nil
    }
    
    static func getMemoryUsage() -> (used: String, free: String, total: String)? {
        let totalMemoryBytes = ProcessInfo.processInfo.physicalMemory
        
        var hostSize = mach_msg_type_number_t(MemoryLayout<vm_statistics64_data_t>.size / MemoryLayout<integer_t>.size)
        var hostInfo = vm_statistics64()
        let hostResult = withUnsafeMutablePointer(to: &hostInfo) {
            $0.withMemoryRebound(to: integer_t.self, capacity: Int(hostSize)) {
                host_statistics64(mach_host_self(), HOST_VM_INFO64, $0, &hostSize)
            }
        }
        
        guard hostResult == KERN_SUCCESS else {
            return nil
        }
        
        let pageSize = vm_kernel_page_size
        let activeBytes = UInt64(hostInfo.active_count) * UInt64(pageSize)
        let inactiveBytes = UInt64(hostInfo.inactive_count) * UInt64(pageSize)
        let wiredBytes = UInt64(hostInfo.wire_count) * UInt64(pageSize)
        let compressedBytes = UInt64(hostInfo.compressor_page_count) * UInt64(pageSize)
        
        
        let freeBytes = UInt64(hostInfo.free_count) * UInt64(pageSize) + inactiveBytes
        
        let usedBytes = activeBytes + inactiveBytes + wiredBytes + compressedBytes
        
        return (
            used: "\(usedBytes)",
            free: "\(freeBytes)",
            total: "\(totalMemoryBytes)"
        )
    }
    
}
