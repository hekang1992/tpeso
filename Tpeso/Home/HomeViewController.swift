//
//  HomeViewController.swift
//  Tpeso
//
//  Created by tom on 2025/5/19.
//

import UIKit
import TYAlertController

class HomeViewController: BaseViewController {
    
    var editGrand: Bool = false
    var deleteGrand: Bool = false
    
    private var scrollView: UIScrollView?
    private var stackView: UIStackView?
    
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
    
//    lazy var stackView: UIStackView = {
//        let stackView = UIStackView()
//        stackView.axis = .vertical       // 垂直排列
//        stackView.spacing = 5           // 间距 5 像素
//        stackView.distribution = .fill  // 填充方式（可调整）
//        stackView.alignment = .fill
//        return stackView
//    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        return bgView
    }()
    
    lazy var imageIcon: UIImageView = {
        let imageIcon = UIImageView()
        imageIcon.image = UIImage(named: "detailmorepiong")
        return imageIcon
    }()
    
    var tricpView: TricpView!
    
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
        
        //add travel plan 添加旅游计划
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
        
        //结束这次旅行
        dataView.deleteBlock = {
            self.dataView.isHidden = true
            self.homeView.isHidden = false
        }
        
        //跟换旅游计划
        dataView.changeBlock = { [weak self] in
            guard let self = self else { return }
            var array = PlaneManager.loadPlaneModelListFromUserDefaults()
            if array.isEmpty {
                ToastConfig.showMessage(form: view, message: "No past travel bills")
            }else {
                let changeTricpView = ChangeTricpView(frame: self.view.bounds)
                changeTricpView.saveTricpArray = array
                changeTricpView.tableView.reloadData()
                let alertVc = TYAlertController(alert: changeTricpView, preferredStyle: .actionSheet)!
                self.present(alertVc, animated: true)
                changeTricpView.completeBlock = { [weak self] name, index in
                    guard let self = self else { return }
                    self.dismiss(animated: true)
                    if name.isEmpty {
                        return
                    }else {
                        let item = array.remove(at: index)
                        array.insert(item, at: 0)
                        PlaneManager.deleteAllPlaneModels()
                        var list = PlaneManager.loadPlaneModelListFromUserDefaults()
                        for model in array {
                             // 先加载已有的数组
                            list.append(model)
                            if let encoded = try? JSONEncoder().encode(list) {
                                UserDefaults.standard.set(encoded, forKey: "PlaneModelListKey")
                                UserDefaults.standard.synchronize()
                            }
                        }
                        self.changUI(model: list[0])
                    }
                }
            }
        }
        
        /// 记录一笔小项
        dataView.editblock = { [weak self] btn in
            let tricpView = TricpView(frame: CGRectMake(0, 0, SCREEN_WIDTH, 690))
            let alertVc = TYAlertController(alert: tricpView, preferredStyle: .actionSheet)!
            alertVc.backgoundTapDismissEnable = true
            self?.present(alertVc, animated: true)
            self?.tricpView = tricpView
            tricpView.block = { btn in
                tricpView.moneyTx.resignFirstResponder()
                DatePickerHelper.showYMDDatePicker { selectedDate in
                    let formatter = DateFormatter()
                    formatter.dateFormat = "dd/MM/yyyy"
                    let time = formatter.string(from: selectedDate)
                    print("selecttime: \(time)")
                    btn.setTitle(time, for: .normal)
                    btn.setTitleColor(.black, for: .normal)
                }
            }
            
            //明细弹窗
            tricpView.completeblock = { [weak self] in
                guard let self = self else { return }
                let money = tricpView.moneyTx.text ?? "0"
                let time = tricpView.timeBtn.titleLabel?.text ?? ""
                let type = tricpView.type
                let imagebase = tricpView.imagebase
                if money.isEmpty {
                    SwiftToastHud.showToastText(form: tricpView, message: "Please enter your budget")
                    return
                }
                if (Int(money) ?? 0) > 50000 {
                    SwiftToastHud.showToastText(form: tricpView, message: "Please enter an max amount within 50,000 pesos.")
                    return
                }
                if time.contains("time") {
                    SwiftToastHud.showToastText(form: tricpView, message: "Please choose your time")
                    return
                }
                if type.isEmpty {
                    SwiftToastHud.showToastText(form: tricpView, message: "Please choose your consumpiton type")
                    return
                }
                
                let model = listTricpModel()
                model.imageStr = type
                model.money = money
                model.timehour = time
                model.photolst = imagebase
                model.hour = LoginInfo.currentTimestamp
                savetricpInfo(with: model)
            }
            
            tricpView.camerablock = { [weak self] btn in
                guard let self = self else { return }
                tricpView.moneyTx.resignFirstResponder()
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
                    
                    
                    tricpimgeView.block1 = { [weak self] in
                        guard let self = self else { return }
                        UIView.animate(withDuration: 0.25, animations: {
                            bgView.alpha = 0
                            self.tricpimgeView.frame = CGRect(x: 0, y: SCREEN_HEIGHT, width: SCREEN_WIDTH, height: 300)
                        }, completion: { _ in
                            bgView.removeFromSuperview()
                            self.tricpimgeView.removeFromSuperview()
                        })
                        
                        MediaPickerHelper.shared.requestPhotoLibraryAccess(presentingVC: alertVc) {
                            let picker = UIImagePickerController()
                            picker.sourceType = .photoLibrary
                            picker.delegate = self
                            alertVc.present(picker, animated: true)
                        }
                        
                    }
                    tricpimgeView.block2 = { [weak self] in
                        guard let self = self else { return }
                        UIView.animate(withDuration: 0.25, animations: {
                            bgView.alpha = 0
                            self.tricpimgeView.frame = CGRect(x: 0, y: SCREEN_HEIGHT, width: SCREEN_WIDTH, height: 300)
                        }, completion: { _ in
                            bgView.removeFromSuperview()
                            self.tricpimgeView.removeFromSuperview()
                        })
                        
                        MediaPickerHelper.shared.requestCameraAccess(presentingVC: alertVc) {
                            let picker = UIImagePickerController()
                            picker.sourceType = .camera
                            picker.delegate = self
                            alertVc.present(picker, animated: true)
                        }
                        
                    }
                    tricpimgeView.block3 = { [weak self] in
                        guard let self = self else { return }
                        UIView.animate(withDuration: 0.25, animations: {
                            bgView.alpha = 0
                            self.tricpimgeView.frame = CGRect(x: 0, y: SCREEN_HEIGHT, width: SCREEN_WIDTH, height: 300)
                        }, completion: { _ in
                            bgView.removeFromSuperview()
                            self.tricpimgeView.removeFromSuperview()
                        })
                    }
                    
                }
            }
            
        }
        
        dataView.settingBtnblock = { [weak self] in
            guard let self = self else { return }
            let stVc = SettingViewController()
            self.navigationController?.pushViewController(stVc, animated: true)
        }
        
    }
    
    
    func isJourNameExists(_ name: String) -> Bool {
        if editGrand {
            return false
        }else {
            let includeety = UserDefaults.standard.object(forKey: "includeety") as? String ?? ""
            let savedArray = UserDefaults.standard.array(forKey: includeety) as? [[String: String]] ?? []
            return savedArray.contains { $0["name"]?.lowercased() == name.lowercased() }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //获取最新的一个模型
        let listArray = PlaneManager.loadPlaneModelListFromUserDefaults()
        if let model = listArray.first {
            changUI(model: model)
        }else {
            self.homeView.isHidden = false
            self.dataView.isHidden = true
        }
        
    }
    
    private func changUI(ischage: String? = "0", index: Int? = 0, model: PlaneModel) {
        let name = model.title ?? ""
        if !name.isEmpty {
            self.showEidtView()
            
            self.homeView.isHidden = true
            self.dataView.isHidden = false
            
            self.dataView.tnameLabel.text = model.title ?? ""
            
            let startTime = model.starttime ?? ""
            let endTime = model.endtime ?? ""
            
            let money = model.amount ?? ""
            self.dataView.moneyLabel.text = "\(money)₱"
            
            let num = self.daysFromNow(targetDateString: startTime) ?? 0
            var fullText = ""
            if num < 0 {
                fullText = "On the road now."
                self.dataView.timeLabel.text = fullText
                self.dataView.timeLabel.font = .boldFontOfSize(size: 15)
                self.dataView.tnameLabel.textColor = .black
            }else {
                fullText = "Started \(num) days ago"
                let attributedString = NSMutableAttributedString(string: fullText)
                if let boldRange = fullText.range(of: "\(num)") {
                    let nsRange = NSRange(boldRange, in: fullText)
                    attributedString.addAttributes([
                        .font: UIFont.boldSystemFont(ofSize: 20),
                        .foregroundColor: UIColor.black
                    ], range: nsRange)
                }
                self.dataView.timeLabel.attributedText = attributedString
            }
            
            self.dataView.timedescLabel.text = "\(startTime)-\(endTime)"
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                self.updateProgress(currentValue: Int(money) ?? 0)
            }
            
            self.dataView.block = { [weak self] moreBtn in
                guard let self = self else { return }
                self.bgView.backgroundColor = UIColor.black.withAlphaComponent(0.35)
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
                    
                    //删除
                    oneBtn.rx.tap.subscribe(onNext: { [weak self] in
                        guard let self = self else { return }
                        bgView.removeFromSuperview()
                        deleteTricp(bgView: bgView, type: "0")
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
    
    private func deleteTricp(bgView: UIView, type: String) {
        if type == "1" {
            let sureView = SureDeleteTricpView(frame: self.view.bounds)
            let alertVc = TYAlertController(alert: sureView, preferredStyle: .alert)!
            self.present(alertVc, animated: true)
            sureView.block = { [weak self] in
                self?.dismiss(animated: true)
            }
            sureView.block1 = { [weak self] in
                guard let self = self else { return }
                self.dismiss(animated: true) {
                    let listArray = PlaneManager.loadPlaneModelListFromUserDefaults()
                    let title = listArray.first?.title ?? ""
                    PlaneManager.deletePlaneModel(withTitle: title)
                    self.dataView.isHidden = true
                    self.homeView.isHidden = false
                }
            }
        }else {
            let listArray = PlaneManager.loadPlaneModelListFromUserDefaults()
            let title = listArray.first?.title ?? ""
            PlaneManager.deletePlaneModel(withTitle: title)
            self.dataView.isHidden = true
            self.homeView.isHidden = false
        }
        
    }
    
    
    //添加旅游计划
    private func popCompleteView() {
        let compleView = ApplyView(frame: CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT))
        let alertVc = TYAlertController(alert: compleView, preferredStyle: .actionSheet)!
        self.present(alertVc, animated: true)
        
        if self.editGrand {
            let allArray = PlaneManager.loadPlaneModelListFromUserDefaults()
            let model = allArray[0]
            compleView.phoneTx.text = model.title;
            compleView.addTx.text = model.amount;
            compleView.leftlabel.text = model.starttime;
            compleView.rightlabel.text = model.endtime;
            compleView.writeView.text = model.desc;
        }
        
        ///savetips
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
                let model: PlaneModel = PlaneModel()
                model.title = name
                model.amount = money
                model.starttime = startTime
                model.endtime = endTime
                model.desc = desc
                let allArray = PlaneManager.loadPlaneModelListFromUserDefaults()
                if allArray.count > 0 {
                    let editmodel = allArray[0]
                    //如果是编辑状态,则删除被编辑的,然后在保存新的
                    if self.editGrand {
                        model.listTricp = editmodel.listTricp ?? []
                        PlaneManager.deletePlaneModel(withTitle: editmodel.title ?? "")
                    }else {
                        model.listTricp = []
                    }
                }
                                
                //保存旅游计划
                PlaneManager.savePlaneModelToLocalList(model)
                //更改页面UI如果有数据的话
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                    self.changUI(model: model)
                }
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

extension HomeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true) {
            
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            
            let compressionQuality: CGFloat = 0.5
            
            if let imageData = image.jpegData(compressionQuality: compressionQuality) {
                print("压缩后的图片大小: \(imageData.count / 1024) KB")
                picker.dismiss(animated: true) {
                    self.tricpView.imagebase.append(self.imageToBase64String(image) ?? "")
                    let count = self.tricpView.imagebase.count
                    if count > 9 {
                        self.tricpView.imagebase.removeLast()
                        ToastConfig.showMessage(form: self.tricpView, message: "Maximum of 9 images can be uploaded.")
                        return
                    }
                    self.tricpView.cameraBtn.setTitleColor(UIColor.black, for: .normal)
                    self.tricpView.cameraBtn.setTitle(String(count), for: .normal)
                    self.tricpView.cameraBtn.setBackgroundImage(image, for: .normal)
                    
                }
                
            }
            
            
            
        }
        
    }
    
    func imageToBase64String(_ image: UIImage) -> String? {
        // 1. 将图片转换为 Data（PNG 或 JPEG 格式）
        guard let imageData = image.pngData() else { return nil } // 或用 `jpegData(compressionQuality:)`
        
        // 2. 将 Data 转换为 Base64 字符串
        let base64String = imageData.base64EncodedString(options: .lineLength64Characters)
        return base64String
    }
    
    ///保存小项目---
    private func savetricpInfo(with listInfo: listTricpModel) {
        let allArray = PlaneManager.loadPlaneModelListFromUserDefaults()
        if allArray.count > 0 {
            let existingModel = allArray[0]
            var updatedList = existingModel.listTricp ?? []
            updatedList.append(listInfo)
            let title = existingModel.title ?? ""
            PlaneManager.updateListTricpInPlaneModel(withTitle: title, newList: updatedList)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                self.dismiss(animated: true) {
                    self.changUI(model: existingModel)
                    SwiftToastHud.showToastText(form: self.view, message: "Save success")
                }
            }
        }
        
    }
    
    private func showEidtView(index: Int? = 0) {
        // 0. 清空旧视图中的内容（只移除 stackView 的内容）
        stackView?.arrangedSubviews.forEach { view in
            stackView?.removeArrangedSubview(view)
            view.removeFromSuperview()
        }

        // 1. 初始化 ScrollView（如果没创建过）
        if scrollView == nil {
            let sv = UIScrollView()
            dataView.greenView.insertSubview(sv, belowSubview: dataView.editBtn)
            sv.snp.makeConstraints { make in
                make.left.bottom.equalToSuperview()
                make.width.equalTo(SCREEN_WIDTH)
                make.top.equalToSuperview().offset(35)
            }
            scrollView = sv
        }

        // 2. 初始化 StackView（如果没创建过）
        if stackView == nil {
            let sv = UIStackView()
            sv.axis = .vertical
            sv.spacing = 5
            sv.distribution = .fill
            sv.alignment = .fill
            scrollView?.addSubview(sv)
            sv.snp.makeConstraints { make in
                make.top.left.right.equalToSuperview()
                make.width.equalTo(SCREEN_WIDTH)
                make.bottom.equalToSuperview().offset(-5)
            }
            stackView = sv
        }

        // 3. 加载数据并填充 UI
        let modelArray = PlaneManager.loadPlaneModelListFromUserDefaults()
        let model = modelArray[index ?? 0]
        let listTricp = model.listTricp ?? []

        listTricp.forEach { model in
            let homeListView = HomeListView()

            homeListView.block = { [weak self] in
                guard let self = self else { return }
                let detailvc = HomeDetailViewViewController()
                detailvc.jsonArray = listTricp
                self.navigationController?.pushViewController(detailvc, animated: true)
            }

            let money = model.money ?? ""
            let imageName = model.imageStr ?? ""

            homeListView.imgerView.image = UIImage(named: imageName)
            homeListView.nameLabel.text = "\(imageName) - ₱\(money)"

            homeListView.snp.makeConstraints { make in
                make.height.equalTo(72)
            }

            stackView?.addArrangedSubview(homeListView)
        }
    }

    
}
