//
//  LoginViewController.swift
//  Tpeso
//
//  Created by 何康 on 2025/5/19.
//

import UIKit
import RxGesture

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
            sendBtn.isEnabled = false
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCountdown), userInfo: nil, repeats: true)
        }).disposed(by: disposeBag)
        
        sureBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            UIApplication.shared.windows.first?.rootViewController = BaseNavigationController(rootViewController: HomeViewController())
        }).disposed(by: disposeBag)
        
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
