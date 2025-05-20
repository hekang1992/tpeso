//
//  DateTimeManager.swift
//  Tpeso
//
//  Created by 何康 on 2025/5/20.
//

import UIKit
import Toast_Swift
import BRPickerView

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
        view.makeToast(message, duration: 2.0, position: .center)
    }
}

class HomeListSaveMessage {
    
    static func loadAllJourInfo() -> [[String: String]] {
        return UserDefaults.standard.array(forKey: "JourInfoArray") as? [[String: String]] ?? []
    }
    
    static func clearAllJourInfo() {
        UserDefaults.standard.removeObject(forKey: "JourInfoArray")
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
