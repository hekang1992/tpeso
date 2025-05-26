//
//  DateTimeManager.swift
//  Tpeso
//
//  Created by tom on 2025/5/20.
//

import UIKit
import BRPickerView
import KRProgressHUD

class DatePickerHelper {
    
    static func showYMDDatePicker(
        title: String = "Select time",
        selectedDate: Date? = nil,
        minDate: Date? = nil,
        maxDate: Date? = nil,
        completion: @escaping (Date) -> Void
    ) {
        let datePickerView = BRDatePickerView()
        datePickerView.pickerMode = .YMD
        datePickerView.title = title
        
        datePickerView.selectDate = selectedDate ?? Date()
        
        datePickerView.minDate = minDate
        datePickerView.maxDate = maxDate
        
        datePickerView.resultBlock = { selectDate, _ in
            if let date = selectDate {
                completion(date)
            }
        }
        
        datePickerView.show()
    }
}


class SwiftToastHud {
    static func showToastText(form view: UIView, message: String) {
        KRProgressHUD.showMessage(message)
    }
}

class HomeListSaveMessage {
    
    static func loadAllJourInfo() -> [[String: String]] {
        let includeety = UserDefaults.standard.object(forKey: "includeety") as? String ?? ""
        return UserDefaults.standard.array(forKey: includeety) as? [[String: String]] ?? []
    }
    
    static func clearAllJourInfo() {
        let includeety = UserDefaults.standard.object(forKey: "includeety") as? String ?? ""
        UserDefaults.standard.removeObject(forKey: includeety)
        UserDefaults.standard.synchronize()
    }
    
}

extension UIApplication {
    var currentKeyWindow: UIWindow? {
        if #available(iOS 15.0, *) {
            return UIApplication.shared.connectedScenes
                .filter { $0.activationState == .foregroundActive }
                .compactMap { $0 as? UIWindowScene }
                .first?.windows
                .first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        }
    }
}
