//
//  SettingViewController.swift
//  Tpeso
//
//  Created by 何康 on 2025/5/20.
//

import UIKit
import TYAlertController
import KRProgressHUD

class SettingViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor("#C4E961")
        
        
        let backBtn = UIButton(type: .custom)
        backBtn.setImage(UIImage(named: "backimge"), for: .normal)
        
        view.addSubview(backBtn)
        backBtn.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 30, height: 30))
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(5)
            make.left.equalToSuperview().offset(18)
        }
        
        backBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.navigationController?.popViewController(animated: true)
        }).disposed(by: disposeBag)
        
        let nameLabel = UILabel()
        nameLabel.text = "Settings"
        nameLabel.font = .regularFontOfSize(size: 18)
        nameLabel.textColor = UIColor("#000000")
        nameLabel.textAlignment = .center
        
        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(backBtn.snp.centerY)
            make.height.equalTo(20)
        }
        
        let icon = UIImageView()
        icon.image = UIImage(named: "setimgeicon")
        view.addSubview(icon)
        icon.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(50)
            make.size.equalTo(CGSize(width: 120, height: 120))
        }
        
        let whiteView = UIView()
        whiteView.backgroundColor = .white
        whiteView.layer.cornerRadius = 15
        whiteView.layer.masksToBounds = true
        view.addSubview(whiteView)
        whiteView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(18)
            make.height.equalTo(50)
            make.top.equalTo(icon.snp.bottom).offset(21)
        }
        
        let white1View = UIView()
        white1View.backgroundColor = .white
        white1View.layer.cornerRadius = 15
        white1View.layer.masksToBounds = true
        view.addSubview(white1View)
        white1View.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(18)
            make.height.equalTo(50)
            make.top.equalTo(whiteView.snp.bottom).offset(14)
        }
        
        
        
        let icon1 = UIImageView()
        icon1.image = UIImage(named: "logooutimge")
        whiteView.addSubview(icon1)
        icon1.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(22)
            make.size.equalTo(CGSize(width: 22, height: 22))
        }
        
        let outLabel = UILabel()
        outLabel.text = "Exit the account"
        outLabel.font = .regularFontOfSize(size: 12)
        outLabel.textColor = UIColor("#333333")
        outLabel.textAlignment = .left
        whiteView.addSubview(outLabel)
        outLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(icon1.snp.right).offset(8)
            make.right.equalToSuperview()
            make.height.equalTo(50)
        }
        
        let icon2 = UIImageView()
        icon2.image = UIImage(named: "delimgeicon")
        white1View.addSubview(icon2)
        icon2.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(22)
            make.size.equalTo(CGSize(width: 22, height: 22))
        }
        
        let delLabel = UILabel()
        delLabel.text = "Delete the account"
        delLabel.font = .regularFontOfSize(size: 12)
        delLabel.textColor = UIColor("#333333")
        delLabel.textAlignment = .left
        white1View.addSubview(delLabel)
        delLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(icon1.snp.right).offset(8)
            make.right.equalToSuperview()
            make.height.equalTo(50)
        }
        
        whiteView.rx.tapGesture().when(.recognized).subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            let exitView = ExitView(frame: CGRectMake(0, 0, SCREEN_WIDTH, 300))
            exitView.imge.image = UIImage(named: "exitaccimge")
            let alertVc = TYAlertController(alert: exitView, preferredStyle: .alert)!
            alertVc.backgoundTapDismissEnable = true
            self.present(alertVc, animated: true)
            exitView.block = { [weak self] in
                self?.dismiss(animated: true)
            }
            exitView.block1 = { [weak self] in
                guard let self = self else { return }
                self.dismiss(animated: true) {
                    self.exitinfo()
                }
            }
        }).disposed(by: disposeBag)
        
        white1View.rx.tapGesture().when(.recognized).subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            let exitView = ExitView(frame: CGRectMake(0, 0, SCREEN_WIDTH, 300))
            exitView.imge.image = UIImage(named: "cancelimgeacount")
            let alertVc = TYAlertController(alert: exitView, preferredStyle: .alert)!
            alertVc.backgoundTapDismissEnable = true
            self.present(alertVc, animated: true)
            exitView.block = { [weak self] in
                self?.dismiss(animated: true)
            }
            exitView.block1 = { [weak self] in
                guard let self = self else { return }
                self.dismiss(animated: true) {
                    self.deleingeadre()
                }
            }
        }).disposed(by: disposeBag)
        
    }

}

extension SettingViewController {
    
    private func exitinfo() {
        KRProgressHUD.show()
        let man = NetworkRequest()
        let result = man.getRequest(url: "/tplink/baibai").sink { _ in
            KRProgressHUD.dismiss()
        } receiveValue: { [weak self] data in
            KRProgressHUD.dismiss()
            guard let self = self else { return }
            do {
                let model = try JSONDecoder().decode(BaseModel.self, from: data)
                let invalidValues: Set<String> = ["0", "00"]
                if invalidValues.contains(model.laminacy) {
                    UserDefaults.standard.set("", forKey: "stigmative")
                    UserDefaults.standard.set("", forKey: "xyz")
                    UserDefaults.standard.set("", forKey: "esee")
                    UserDefaults.standard.synchronize()
                    
                    UIApplication.shared.windows.first?.rootViewController = IS_LOGIN ? BaseNavigationController(rootViewController: HomeViewController()) : BaseNavigationController(rootViewController: LoginViewController())
                    
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
    
    private func deleingeadre() {
        KRProgressHUD.show()
        let man = NetworkRequest()
        let result = man.getRequest(url: "/tplink/sten").sink { _ in
            KRProgressHUD.dismiss()
        } receiveValue: { [weak self] data in
            KRProgressHUD.dismiss()
            guard let self = self else { return }
            do {
                let model = try JSONDecoder().decode(BaseModel.self, from: data)
                let invalidValues: Set<String> = ["0", "00"]
                if invalidValues.contains(model.laminacy) {
                    UserDefaults.standard.set("", forKey: "stigmative")
                    UserDefaults.standard.set("", forKey: "xyz")
                    UserDefaults.standard.set("", forKey: "esee")
                    UserDefaults.standard.synchronize()
                    
                    UIApplication.shared.windows.first?.rootViewController = IS_LOGIN ? BaseNavigationController(rootViewController: HomeViewController()) : BaseNavigationController(rootViewController: LoginViewController())
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
