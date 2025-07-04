//
//  LoginViewController.swift
//  Tpeso
//
//  Created by tom on 2025/5/19.
//

import UIKit
import RxGesture
import KRProgressHUD

class LoginViewController: BaseViewController {
    
    var timer: Timer?
    var timeRemaining = 60
    
    lazy var ctImageView: UIImageView = {
        let ctImageView = UIImageView()
        ctImageView.image = UIImage(named: "loginbgimage")
        ctImageView.isUserInteractionEnabled = true
        return ctImageView
    }()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "logince")
        bgImageView.isUserInteractionEnabled = true
        return bgImageView
    }()
    
    lazy var phoneLabel: UILabel = {
        let phoneLabel = UILabel()
        phoneLabel.text = "Mobile phone number"
        phoneLabel.textColor = UIColor("#333333")
        phoneLabel.textAlignment = .left
        phoneLabel.font = .regularFontOfSize(size: 15)
        return phoneLabel
    }()
    
    lazy var pImageView: UIImageView = {
        let pImageView = UIImageView()
        pImageView.image = UIImage(named: "phonecode")
        pImageView.isUserInteractionEnabled = true
        return pImageView
    }()
    
    lazy var coceLabel: UILabel = {
        let coceLabel = UILabel()
        coceLabel.text = "Verification code"
        coceLabel.textColor = UIColor("#333333")
        coceLabel.textAlignment = .left
        coceLabel.font = .regularFontOfSize(size: 15)
        return coceLabel
    }()
    
    lazy var codeImageView: UIImageView = {
        let codeImageView = UIImageView()
        codeImageView.image = UIImage(named: "phonecode")
        codeImageView.isUserInteractionEnabled = true
        return codeImageView
    }()
    
    lazy var sureBtn: UIButton = {
        let sureBtn = UIButton(type: .custom)
        sureBtn.setTitle("Start bookkeeping", for: .normal)
        sureBtn.backgroundColor = UIColor("#FFB12A")
        sureBtn.layer.cornerRadius = 25
        sureBtn.layer.masksToBounds = true
        sureBtn.titleLabel?.font = .boldFontOfSize(size: 16)
        return sureBtn
    }()
    
    lazy var sixLabel: UILabel = {
        let sixLabel = UILabel()
        sixLabel.text = "+63"
        sixLabel.textColor = UIColor("#333333")
        sixLabel.textAlignment = .center
        sixLabel.font = .regularFontOfSize(size: 15)
        return sixLabel
    }()
    
    lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor("#333333")
        return lineView
    }()
    
    lazy var phoneTx: UITextField = {
        let phoneTx = UITextField()
        phoneTx.keyboardType = .numberPad
        let attrString = NSMutableAttributedString(string: "Please enter", attributes: [
            .foregroundColor: UIColor("#999999") as Any,
            .font: UIFont.regularFontOfSize(size: 15)
        ])
        phoneTx.attributedPlaceholder = attrString
        phoneTx.font = .regularFontOfSize(size: 15)
        phoneTx.textColor = UIColor("#333333")
        return phoneTx
    }()
    
    lazy var codeTx: UITextField = {
        let codeTx = UITextField()
        codeTx.keyboardType = .numberPad
        let attrString = NSMutableAttributedString(string: "Please enter", attributes: [
            .foregroundColor: UIColor("#999999") as Any,
            .font: UIFont.regularFontOfSize(size: 15)
        ])
        codeTx.attributedPlaceholder = attrString
        codeTx.font = .regularFontOfSize(size: 15)
        codeTx.textColor = UIColor("#333333")
        return codeTx
    }()
    
    lazy var sendBtn: UIButton = {
        let sendBtn = UIButton(type: .custom)
        sendBtn.setTitle("Send text messages", for: .normal)
        sendBtn.setTitleColor(UIColor("#43C63B"), for: .normal)
        sendBtn.titleLabel?.font = .mediumFontOfSize(size: 13)
        sendBtn.contentHorizontalAlignment = .right
        return sendBtn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.addSubview(ctImageView)
        ctImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        ctImageView.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 340, height: 310))
        }
        
        bgImageView.addSubview(phoneLabel)
        phoneLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(43)
            make.left.equalToSuperview().offset(15)
            make.height.equalTo(15)
        }
        
        bgImageView.addSubview(pImageView)
        pImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 310, height: 54))
            make.top.equalTo(phoneLabel.snp.bottom).offset(9)
        }
        
        bgImageView.addSubview(coceLabel)
        bgImageView.addSubview(codeImageView)
        
        coceLabel.snp.makeConstraints { make in
            make.top.equalTo(pImageView.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(15)
            make.height.equalTo(15)
        }
        codeImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 310, height: 54))
            make.top.equalTo(coceLabel.snp.bottom).offset(9)
        }
        
        bgImageView.addSubview(sureBtn)
        sureBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 303, height: 49))
            make.top.equalTo(codeImageView.snp.bottom).offset(20)
        }
        
        pImageView.addSubview(sixLabel)
        sixLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
            make.width.equalTo(50)
            make.height.equalTo(49)
        }
        
        pImageView.addSubview(lineView)
        lineView.snp.makeConstraints { make in
            make.right.equalTo(sixLabel.snp.right)
            make.centerY.equalToSuperview()
            make.height.equalTo(20)
            make.width.equalTo(1)
        }
        
        pImageView.addSubview(phoneTx)
        phoneTx.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(lineView.snp.right).offset(10)
            make.right.equalToSuperview()
            make.height.equalTo(50)
        }
        
        codeImageView.addSubview(codeTx)
        codeTx.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 120, height: 50))
        }
        
        codeImageView.addSubview(sendBtn)
        sendBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-15)
            make.size.equalTo(CGSize(width: 180, height: 50))
        }
        
        sendBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            //获取验证码
            getcode()
        }).disposed(by: disposeBag)
        
        sureBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            getloginpage()
        }).disposed(by: disposeBag)
        
        
        let location = LocationManager()
        location.getLocationInfo { model in
            
        }
    }
    
    @objc func updateCountdown() {
        timeRemaining -= 1
        sendBtn.setTitle("\(timeRemaining)", for: .normal)
        if timeRemaining <= 0 {
            timer?.invalidate()
            timer = nil
            sendBtn.isEnabled = true
            sendBtn.setTitle("Send text messages", for: .normal)
        }
    }
    
    deinit {
        timer?.invalidate()
    }
}

extension LoginViewController {
    
    private func getcode() {
        let phone = self.phoneTx.text ?? ""
        if phone.isEmpty {
            ToastConfig.showMessage(form: view, message: "Please enter your phone number")
            return
        }
        KRProgressHUD.show()
        let man = NetworkRequest()
        let dict = ["informationture": phone]
        let result = man.requsetData(url: "/tplink/cad", parameters: dict, contentType: .multipartFormData).sink { _ in
            KRProgressHUD.dismiss()
        } receiveValue: { [weak self] data in
            KRProgressHUD.dismiss()
            guard let self = self else { return }
            do {
                let model = try JSONDecoder().decode(BaseModel.self, from: data)
                let invalidValues: Set<String> = ["0", "00"]
                if invalidValues.contains(model.laminacy) {
                    sendBtn.isEnabled = false
                    timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCountdown), userInfo: nil, repeats: true)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                    ToastConfig.showMessage(form: self.view, message: model.worldan ?? "")
                }
            } catch  {
                print("JSON: \(error)")
            }
        }
        result.store(in: &cancellables)
        
    }
    
    private func getloginpage() {
        let phone = self.phoneTx.text ?? ""
        if phone.isEmpty {
            ToastConfig.showMessage(form: view, message: "Please enter your phone number")
            return
        }
        KRProgressHUD.show()
        let includeety = phone
        let summer = self.codeTx.text ?? ""
        let vsee = DeviceInfo.isVPNEnabled//vpn
        let psee = DeviceInfo.isUsingProxy//dl
        let lsee = Locale.preferredLanguages.first ?? "en"//en
        let ranacy = "1"//hx
        
        let dict = ["includeety": includeety,
                    "summer": summer,
                    "vsee": vsee,
                    "psee": psee,
                    "lsee": lsee,
                    "ranacy": ranacy]
        
        let man = NetworkRequest()
        
        let result = man.requsetData(url: "/tplink/ug", parameters: dict, contentType: .multipartFormData).sink { _ in
            KRProgressHUD.dismiss()
        } receiveValue: { [weak self] data in
            KRProgressHUD.dismiss()
            guard let self = self else { return }
            do {
                let model = try JSONDecoder().decode(BaseModel.self, from: data)
                let invalidValues: Set<String> = ["0", "00"]
                if invalidValues.contains(model.laminacy) {
                    let stigmative = model.raceast?.stigmative ?? ""
                    let xyz = model.raceast?.xyz ?? ""
                    let byy = model.raceast?.byy ?? ""
                    let includeety = model.raceast?.includeety ?? ""
                    UserDefaults.standard.set(stigmative, forKey: "stigmative")
                    UserDefaults.standard.set(xyz, forKey: "xyz")
                    UserDefaults.standard.set(byy, forKey: "byy")
                    UserDefaults.standard.set(includeety, forKey: "includeety")
                    UserDefaults.standard.synchronize()
                    if byy == "vcd" {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                            let webVc = WebViewController()
                            let pageUrl =  URLQueryAppender.appendQueryParameters(to: xyz, parameters: DeviceInfo.toDictionary())!
                            webVc.pageUrl = pageUrl
                            UIApplication.shared.windows.first?.rootViewController = BaseNavigationController(rootViewController: webVc)
                        }
                    }else {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                            UIApplication.shared.windows.first?.rootViewController = BaseNavigationController(rootViewController: HomeViewController())
                        }
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                    ToastConfig.showMessage(form: self.view, message: model.worldan ?? "")
                }
            } catch  {
                print("JSON: \(error)")
            }
        }

        result.store(in: &cancellables)
        
    }
    
}
