//
//  HomeViewController.swift
//  Tpeso
//
//  Created by 何康 on 2025/5/19.
//

import UIKit
import TYAlertController

class HomeViewController: BaseViewController {
    
    var editGrand: Bool = false
    var deleteGrand: Bool = false
    
    lazy var homeView: HomeView = {
        let homeView = HomeView()
        homeView.isHidden = true
        return homeView
    }()
    
    lazy var dataView: HageDataView = {
        let dataView = HageDataView()
        dataView.isHidden = true
        return dataView
    }()
    
    lazy var tricpimgeView: TCameraView = {
        let tricpimgeView = TCameraView()
        return tricpimgeView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(homeView)
        homeView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(dataView)
        dataView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        homeView.applyBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.editGrand = false
            popCompleteView()
        }).disposed(by: disposeBag)
        
        homeView.settingBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            let stVc = SettingViewController()
            self.navigationController?.pushViewController(stVc, animated: true)
        }).disposed(by: disposeBag)
        
        /// 记录一笔
        dataView.editblock = { [weak self] btn in
            let tricpView = TricpView(frame: CGRectMake(0, 0, SCREEN_WIDTH, 690))
            let alertVc = TYAlertController(alert: tricpView, preferredStyle: .actionSheet)!
            alertVc.backgoundTapDismissEnable = true
            self?.present(alertVc, animated: true)
            
            tricpView.block = { btn in
                DatePickerHelper.showYMDDatePicker { selectedDate in
                    let formatter = DateFormatter()
                    formatter.dateFormat = "dd/MM/yyyy"
                    let time = formatter.string(from: selectedDate)
                    print("selecttime: \(time)")
                    btn.setTitle(time, for: .normal)
                    btn.setTitleColor(.black, for: .normal)
                }
            }
            
            tricpView.camerablock = { [weak self] btn in
                guard let self = self else { return }
                let bgView = UIView()
                bgView.backgroundColor = UIColor.black.withAlphaComponent(0.45)
                if let window = UIApplication.shared.currentKeyWindow {
                    window.addSubview(bgView)
                    bgView.snp.makeConstraints { make in
                        make.edges.equalToSuperview()
                    }
                    let finalFrame = CGRect(x: 0, y: SCREEN_HEIGHT - 300, width: SCREEN_WIDTH, height: 300)
                    
                    self.tricpimgeView.frame = CGRect(x: 0, y: SCREEN_HEIGHT, width: SCREEN_WIDTH, height: 300)
                    
                    // 2. 先添加到窗口（此时在屏幕外）
                    window.addSubview(self.tricpimgeView)
                    
                    // 3. 执行从下往上的动画
                    UIView.animate(withDuration: 0.25,
                                   delay: 0,
                                   options: [.curveEaseOut],
                                   animations: {
                        self.tricpimgeView.frame = finalFrame
                    }, completion: nil)
                    
                    bgView.rx.tapGesture().when(.recognized).subscribe(onNext: { [weak self] _ in
                        guard let self = self else { return }
                        UIView.animate(withDuration: 0.25, animations: {
                            bgView.alpha = 0
                            self.tricpimgeView.frame = CGRect(x: 0, y: SCREEN_HEIGHT, width: SCREEN_WIDTH, height: 300)
                        }, completion: { _ in
                            bgView.removeFromSuperview()
                            self.tricpimgeView.removeFromSuperview()
                        })
                    }).disposed(by: disposeBag)
                    
                }
            }
            
        }
        
        dataView.settingBtnblock = { [weak self] in
            guard let self = self else { return }
            let stVc = SettingViewController()
            self.navigationController?.pushViewController(stVc, animated: true)
        }
        
    }
    
    
    private func saveJourInfo(with listInfo: [String: String]) {
        var savedArray = UserDefaults.standard.array(forKey: "JourInfoArray") as? [[String: String]] ?? []
        savedArray.append(listInfo)
        UserDefaults.standard.set(savedArray, forKey: "JourInfoArray")
        UserDefaults.standard.synchronize()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            self.changUI()
            SwiftToastHud.showToastText(form: self.view, message: "Save success")
        }
    }
    
    func isJourNameExists(_ name: String) -> Bool {
        if editGrand {
            return false
        }else {
            let savedArray = UserDefaults.standard.array(forKey: "JourInfoArray") as? [[String: String]] ?? []
            return savedArray.contains { $0["name"]?.lowercased() == name.lowercased() }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        changUI()
    }
    
    private func changUI() {
        let allArray = HomeListSaveMessage.loadAllJourInfo()
        if !allArray.isEmpty && allArray.count > 0 {
            self.homeView.isHidden = true
            self.dataView.isHidden = false
            
            let name = allArray[0]["name"] ?? ""
            self.dataView.tnameLabel.text = name
            
            let startTime = allArray[0]["startTime"] ?? ""
            let endTime = allArray[0]["endTime"] ?? ""
            
            let money = allArray[0]["money"] ?? ""
            self.dataView.moneyLabel.text = "\(money)₱"
            
            let num = String(daysFromNow(targetDateString: startTime) ?? 0)
            
            
            let fullText = "Started \(num) days ago"
            let attributedString = NSMutableAttributedString(string: fullText)
            if let boldRange = fullText.range(of: "\(num)") {
                let nsRange = NSRange(boldRange, in: fullText)
                attributedString.addAttributes([
                    .font: UIFont.boldSystemFont(ofSize: 20),
                    .foregroundColor: UIColor.black
                ], range: nsRange)
            }
            self.dataView.timeLabel.attributedText = attributedString
            
            self.dataView.timedescLabel.text = "\(startTime)-\(endTime)"
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                self.updateProgress(currentValue: Int(money) ?? 0)
            }
            
            self.dataView.block = { [weak self] moreBtn in
                guard let self = self else { return }
                let bgView = UIView()
                bgView.backgroundColor = UIColor.black.withAlphaComponent(0.35)
                let imageIcon = UIImageView()
                imageIcon.image = UIImage(named: "detailmorepiong")
                if let window = UIApplication.shared.currentKeyWindow {
                    window.addSubview(bgView)
                    bgView.addSubview(imageIcon)
                    imageIcon.isUserInteractionEnabled = true
                    let oneBtn = UIButton(type: .custom)
                    let twoBtn = UIButton(type: .custom)
                    imageIcon.addSubview(oneBtn)
                    imageIcon.addSubview(twoBtn)
                    bgView.snp.makeConstraints { make in
                        make.edges.equalToSuperview()
                    }
                    imageIcon.snp.makeConstraints { make in
                        make.right.equalTo(moreBtn.snp.right).offset(20)
                        make.top.equalTo(moreBtn.snp.bottom).offset(-10)
                        make.size.equalTo(CGSize(width: 114, height: 166))
                    }
                    oneBtn.snp.makeConstraints { make in
                        make.top.left.right.equalToSuperview()
                        make.height.equalTo(84)
                    }
                    twoBtn.snp.makeConstraints { make in
                        make.bottom.left.right.equalToSuperview()
                        make.height.equalTo(84)
                    }
                    
                    oneBtn.rx.tap.subscribe(onNext: { [weak self] in
                        guard let self = self else { return }
                        bgView.removeFromSuperview()
                        let tricpname = self.dataView.tnameLabel.text ?? ""
                        var allArray = HomeListSaveMessage.loadAllJourInfo()
                        for (index ,dict) in allArray.enumerated() {
                            let name = dict["name"] ?? ""
                            if tricpname == name {
                                allArray.remove(at: index)
                                UserDefaults.standard.set(allArray, forKey: "JourInfoArray")
                                UserDefaults.standard.synchronize()
                            }
                        }
                        changUI()
                    }).disposed(by: disposeBag)
                    
                    twoBtn.rx.tap.subscribe(onNext: { [weak self] in
                        guard let self = self else { return }
                        bgView.removeFromSuperview()
                        self.editGrand = true
                        popCompleteView()
                        
                    }).disposed(by: disposeBag)
                    
                    bgView.rx.tapGesture().when(.recognized).subscribe(onNext: { [weak self] _ in
                        guard let self = self else { return }
                        bgView.removeFromSuperview()
                    }).disposed(by: disposeBag)
                    
                }
                
            }
        }else {
            self.homeView.isHidden = false
            self.dataView.isHidden = true
        }
    }
    
    func daysFromNow(targetDateString: String, format: String = "dd/MM/yyyy") -> Int? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = TimeZone.current
        guard let targetDate = formatter.date(from: targetDateString) else {
            return nil
        }
        
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let targetDay = calendar.startOfDay(for: targetDate)
        
        let components = calendar.dateComponents([.day], from: today, to: targetDay)
        return components.day
    }
    
    private func popCompleteView() {
        
        let compleView = ApplyView(frame: CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT))
        let alertVc = TYAlertController(alert: compleView, preferredStyle: .actionSheet)!
        self.present(alertVc, animated: true)
        
        if self.editGrand {
            let allArray = HomeListSaveMessage.loadAllJourInfo()
            let dict = allArray[0]
            compleView.phoneTx.text = dict["name"] ?? ""
            compleView.addTx.text = dict["money"] ?? ""
            compleView.leftlabel.text = dict["startTime"] ?? ""
            compleView.rightlabel.text = dict["endTime"] ?? ""
            compleView.writeView.text = dict["desc"] ?? ""
        }
        
        compleView.completBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            let name = compleView.phoneTx.text ?? ""
            let money = compleView.addTx.text ?? "0"
            var startTime = compleView.leftlabel.text ?? ""
            if startTime.contains("time") {
                startTime = ""
            }
            var endTime = compleView.rightlabel.text ?? ""
            if endTime.contains("time") {
                endTime = ""
            }
            let desc = compleView.writeView.text ?? ""
            if name.isEmpty {
                SwiftToastHud.showToastText(form: compleView, message: "Please enter the plan name.")
                return
            }else {
                let grand = isJourNameExists(name)
                if grand {
                    SwiftToastHud.showToastText(form: compleView, message: "You already have a journey named \(name).")
                    return
                }
            }
            if money.isEmpty {
                SwiftToastHud.showToastText(form: compleView, message: "Please enter the plan budegt.")
                return
            }else {
                if (Int(money) ?? 0) > 50000 {
                    SwiftToastHud.showToastText(form: compleView, message: "Please enter an max amount within 50,000 pesos.")
                    return
                }
                if (Int(money) ?? 0) < 10000 {
                    SwiftToastHud.showToastText(form: compleView, message: "Please enter an min amount within 10,000 pesos.")
                    return
                }
            }
            if startTime.isEmpty {
                SwiftToastHud.showToastText(form: compleView, message: "Please enter the plan start time.")
                return
            }
            if endTime.isEmpty {
                SwiftToastHud.showToastText(form: compleView, message: "Please enter the plan end time.")
                return
            }
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            if let date1 = dateFormatter.date(from: startTime), let date2 = dateFormatter.date(from: endTime) {
                if date1 > date2 {
                    SwiftToastHud.showToastText(form: compleView, message: "Invalid time range: Start time must precede end time.")
                    return
                }
            }
            
            self.dismiss(animated: true) {
                let json: [String: String] = ["name": name,
                                              "money": money,
                                              "startTime": startTime,
                                              "endTime": endTime,
                                              "desc": desc,
                                              "timestamp": String(Date().timeIntervalSince1970 * 1000)]
                let tricpname = self.dataView.tnameLabel.text ?? ""
                var allArray = HomeListSaveMessage.loadAllJourInfo()
                for (index ,dict) in allArray.enumerated() {
                    let name = dict["name"] ?? ""
                    if tricpname == name {
                        allArray.remove(at: index)
                        UserDefaults.standard.set(allArray, forKey: "JourInfoArray")
                        UserDefaults.standard.synchronize()
                    }
                }
                self.saveJourInfo(with: json)
            }
        }).disposed(by: disposeBag)
        
        compleView.leftBlock = { label in
            DatePickerHelper.showYMDDatePicker { selectedDate in
                let formatter = DateFormatter()
                formatter.dateFormat = "dd/MM/yyyy"
                let time = formatter.string(from: selectedDate)
                print("selecttime: \(time)")
                label.text = time
                label.textColor = .black
            }
        }
        
        compleView.rightBlock = { label in
            DatePickerHelper.showYMDDatePicker { selectedDate in
                let formatter = DateFormatter()
                formatter.dateFormat = "dd/MM/yyyy"
                let time = formatter.string(from: selectedDate)
                print("selecttime: \(time)")
                label.text = time
                label.textColor = .black
            }
        }
        
    }
    
    func updateProgress(currentValue: Int) {
        let minValue = 10000
        let maxValue = 50000
        let clampedValue = min(max(currentValue, minValue), maxValue)
        let progress = Float(clampedValue - minValue) / Float(maxValue - minValue)
        self.dataView.progressView.setProgress(progress, animated: true)
        
    }
    
}
