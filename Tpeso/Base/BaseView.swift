//
//  BaseView.swift
//  Tpeso
//
//  Created by 何康 on 2025/5/19.
//

import UIKit
import SnapKit
import RxSwift

let SCREEN_WIDTH = UIScreen.main.bounds.size.width

let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

var IS_LOGIN: Bool {
    (UserDefaults.standard.object(forKey: "PHONE") as? String)?.isEmpty == false
}

extension UIFont {
    class func regularFontOfSize(size: CGFloat) -> UIFont {
        return UIFont.init(name: "PingFangSC-Regular", size: size)!
    }
    
    class func mediumFontOfSize(size: CGFloat) -> UIFont {
        return UIFont.init(name: "PingFangSC-Medium", size: size)!
    }
    
    class func semiboldFontOfSize(size: CGFloat) -> UIFont {
        return UIFont.init(name: "PingFangSC-Semibold", size: size)!
    }
    
    class func boldFontOfSize(size: CGFloat) -> UIFont {
        return UIFont.init(name: "PingFangSC-Semibold", size: size)!
    }
}

class BaseView: UIView {
   let disposeBag = DisposeBag()
}
