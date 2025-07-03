//
//  WebViewController.swift
//  Tpeso
//
//  Created by tom on 2025/5/27.
//

import UIKit
import WebKit
import StoreKit
import CoreLocation

extension UIScrollView {
    func scrollViewInfoApple(_ configuration: (UIScrollView) -> Void) {
        configuration(self)
    }
}

class WebViewController: BaseViewController {
    
    var pageUrl: String = ""
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = UIColor("#C4E961")
        return bgView
    }()
    
    lazy var webView: WKWebView = {
        let userContentController = WKUserContentController()
        let configuration = WKWebViewConfiguration()
        let scriptNames = ["kslsop",
                           "oplopa",
                           "nakop",
                           "anmls",
                           "nextap",
                           "polad",
                           "poseiko",
                           "mkla",
                           "ifok",
                           "hatVanill",
                           "cilantroT"]
        scriptNames.forEach { userContentController.add(self, name: $0) }
        configuration.userContentController = userContentController
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.scrollView.scrollViewInfoApple {
            $0.showsVerticalScrollIndicator = false
            $0.showsHorizontalScrollIndicator = false
            $0.contentInsetAdjustmentBehavior = .never
            $0.bounces = false
            $0.alwaysBounceVertical = false
        }
        webView.navigationDelegate = self
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        //        let backBtn = UIButton(type: .custom)
        //        backBtn.setImage(UIImage(named: "backimge"), for: .normal)
        //        backBtn.isHidden = true
        //        view.addSubview(backBtn)
        //        backBtn.snp.makeConstraints { make in
        //            make.size.equalTo(CGSize(width: 30, height: 30))
        //            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(5)
        //            make.left.equalToSuperview().offset(18)
        //        }
        //
        //        backBtn.rx.tap.subscribe(onNext: { [weak self] in
        //            guard let self = self else { return }
        //            self.navigationController?.popViewController(animated: true)
        //        }).disposed(by: disposeBag)
        //
        //        let nameLabel = UILabel()
        //        nameLabel.text = ""
        //        nameLabel.font = .regularFontOfSize(size: 18)
        //        nameLabel.textColor = UIColor("#000000")
        //        nameLabel.textAlignment = .center
        //
        //        view.addSubview(nameLabel)
        //        nameLabel.snp.makeConstraints { make in
        //            make.centerX.equalToSuperview()
        //            make.centerY.equalTo(backBtn.snp.centerY)
        //            make.height.equalTo(20)
        //        }
        
        view.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        print("pageUrl=========\(pageUrl)")
        
        if let webUrl = URL(string: pageUrl) {
            let request = URLRequest(url: webUrl)
            webView.load(request)
        }
        
        //        backBtn.rx.tap.subscribe(onNext: { [weak self] in
        //            guard let self = self else { return }
        //            if self.webView.canGoBack {
        //                self.webView.goBack()
        //            }else {
        //                self.navigationController?.popToRootViewController(animated: true)
        //            }
        //        }).disposed(by: disposeBag)
        
    }
    
}

extension WebViewController: WKScriptMessageHandler, WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        let messageName = message.name
        let body = message.body
        print("✈️ messageName========\(messageName)")
        print("✈️ body========\(body)")
        if messageName == "nakop" {
            let auth = CLLocationManager().authorizationStatus
            if auth == .notDetermined {
                toh5("nishakl('\(0)')")
                alertshow(str: "Location")
            }else if auth == .authorizedAlways || auth == .authorizedWhenInUse {
                toh5("nishakl('\(1)')")
            }else {
                toh5("nishakl('\(2)')")
            }
        }else if messageName == "poseiko" {
            contactac(messageName)
        }else if messageName == "kslsop" {
            let typeStr = message.body as? String ?? "1"
            let type = Int(typeStr) ?? 1
            cameraAction(type: type)
        }else if messageName == "oplopa" {
            libAction()
        }else if messageName == "nextap" {
            let dict = LoginInfo.getDeviceInfoDictionary()
            if let jsonstr = toJsontring(dict: dict) {
                toh5("iopasd('\(jsonstr)')")
            }
        }else if messageName == "cilantroT" {
            pingfen()
        }else if messageName == "hatVanill" {
            sendEmail(message.body as? String ?? "")
            
        }else if messageName == "ifok" {
            UserDefaults.standard.set("", forKey: "stigmative")
            UserDefaults.standard.set("", forKey: "xyz")
            UserDefaults.standard.set("", forKey: "byy")
            UserDefaults.standard.set("", forKey: "includeety")
            UserDefaults.standard.synchronize()
            UIApplication.shared.windows.first?.rootViewController =  BaseNavigationController(rootViewController: LoginViewController())
        }else if messageName == "polad" || messageName == "mkla" {
            let location = LocationManager()
            location.getLocationInfo { model in
                let dict = [
                    "close_lid": model.close_lid,
                    "clean_hand": model.clean_hand,
                    "sleepy_owl": model.sleepy_owl,
                    "noisy_cat": model.noisy_cat,
                    "angry_bee": model.angry_bee,
                    "hungry_ant": model.hungry_ant,
                    "fresh_snow": model.fresh_snow,
                    "tiny_fish": model.tiny_fish,
                ]
                let jsonStr = self.toJsontring(dict: dict) ?? ""
                if messageName == "polad" {
                    self.toh5("meiolas('\(jsonStr)')")
                }else if messageName == "mkla" {
                    let dict = ["clean_hand": model.clean_hand,
                                "sleepy_owl": model.sleepy_owl,]
                    let jsonStr = self.toJsontring(dict: dict) ?? ""
                    self.toh5("jkwoas('\(jsonStr)')")
                }
            }
        }else if messageName == "anmls" {
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }else if messageName == "mkla" {
            
        }
    }
    
    func toJsontring(dict: Any)-> String? {
        do {
            let data = try JSONSerialization.data(withJSONObject: dict)
            if let str = String(data: data, encoding: .utf8) {
                return str
            }
        } catch {
            
        }
        return nil
    }
    
    func toh5(_ jsFunc: String) {
        webView.evaluateJavaScript(jsFunc) { (result, error) in
            if let error = error {
                print("JavaScript 执行错误: \(error.localizedDescription)")
            } else if let result = result {
                print("JavaScript 返回结果: \(result)")
            } else {
                print("JavaScript 执行完成，但无返回值")
            }
        }
    }
    
    func alertshow(str: String) {
        let vc = UIAlertController(title: "Tips", message: "\"\(str)\" permission is not open", preferredStyle: .alert)
        vc.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            
        }))
        
        vc.addAction(UIAlertAction(title: "Confirm", style: .destructive, handler: { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }))
        
        navigationController?.present(vc, animated: true)
    }
    
    func pingfen() {
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            SKStoreReviewController.requestReview(in: scene)
        }
    }
    
    func sendEmail(_ mail: String) {
        var mail = mail
        mail = mail.replacingOccurrences(of: "email", with: "mailto")
        let phone = UserDefaults.standard.string(forKey: "includeety") ?? ""
        let name = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String ?? ""
        let str = mail + "?body=\(name)\n\(phone)"
        let encodeStr = str.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        if let url = URL(string: encodeStr) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
}

