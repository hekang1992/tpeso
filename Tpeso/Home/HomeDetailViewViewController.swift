//
//  HomeDetailViewViewController.swift
//  Tpeso
//
//  Created by tom on 2025/5/20.
//

import UIKit
import TYAlertController
import KRProgressHUD

class HomeDetailViewViewController: BaseViewController {
    
    var sortedGroupedArray: [[String : [[String : String]]]]?
    
    var timeStr: String?  {
        didSet {
            guard let timeStr = timeStr else { return }
            timelabel.text = timeStr
        }
    }
    
    lazy var timelabel: UILabel = {
        let timelabel = UILabel()
        timelabel.layer.cornerRadius = 15
        timelabel.layer.masksToBounds = true
        timelabel.textAlignment = .center
        timelabel.textColor = UIColor.white
        timelabel.backgroundColor = UIColor("#80A51C")
        timelabel.font = .regularFontOfSize(size: 14)
        return timelabel
    }()

    var jsonArray: [[String: String]]? {
        didSet {
            guard let jsonArray = jsonArray else { return }
            let grouped = Dictionary(grouping: jsonArray) { element -> String in
                return element["time"] ?? "unknown" // 处理可能的 nil 值
            }
            // 2. 按 "type" 排序 (a, b, c...)
            let sortedGroups = grouped.sorted { $0.key < $1.key }
            
            // 3. 转换为二维数组 [[String: [字典]]]
            let result = sortedGroups.map { [$0.key: $0.value] }
            
            
            let times = sortedGroups.map { $0.key }
            
            let minType = times.min() ?? ""
            let maxType = times.max() ?? ""
            
            timeStr = "\(minType) - \(maxType)"
            // 4. 存储结果或直接使用
            self.sortedGroupedArray = result
            
            tableView.reloadData()
        }
    }
    
    var name: String = ""
    
    lazy var whiteView: UIView = {
        let whiteView = UIView()
        whiteView.backgroundColor = .white
        return whiteView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tableView.estimatedRowHeight = 80
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        return tableView
    }()
    
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
        nameLabel.text = "Consumption records"
        nameLabel.font = .regularFontOfSize(size: 18)
        nameLabel.textColor = UIColor("#000000")
        nameLabel.textAlignment = .center
        
        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(backBtn.snp.centerY)
            make.height.equalTo(20)
        }
        
        
        let greenView = UIView()
        greenView.backgroundColor = UIColor.white
        greenView.layer.cornerRadius = 20
        greenView.layer.masksToBounds = true
        view.addSubview(greenView)
        greenView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 374, height: 96))
            make.top.equalTo(nameLabel.snp.bottom).offset(40)
        }
        
        let imgeIcon = UIImageView()
        imgeIcon.image = UIImage(named: "treeimge")
        view.addSubview(imgeIcon)
        imgeIcon.snp.makeConstraints { make in
            make.top.equalTo(greenView.snp.top)
            make.right.equalToSuperview().offset(-12)
            make.size.equalTo(CGSize(width: 136, height: 146))
        }
        
        let desclabel = UILabel()
        desclabel.text = "Program Name"
        desclabel.font = .regularFontOfSize(size: 14)
        desclabel.textAlignment = .left
        desclabel.textColor = UIColor("#333333")
        
        let namelabel = UILabel()
        namelabel.text = name
        namelabel.font = .boldFontOfSize(size: 20)
        namelabel.textAlignment = .left
        namelabel.textColor = UIColor("#333333")
        
        
        greenView.addSubview(desclabel)
        greenView.addSubview(namelabel)
        
        desclabel.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.top.equalToSuperview().offset(24)
            make.left.equalToSuperview().offset(20)
        }
        
        namelabel.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.top.equalTo(desclabel.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(20)
        }
        
        view.addSubview(whiteView)
        whiteView.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.top.equalTo(imgeIcon.snp.bottom)
        }
        
        
        whiteView.addSubview(timelabel)
        timelabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(20)
            make.size.equalTo(CGSize(width: 200, height: 30))
        }
        
        whiteView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(timelabel.snp.bottom).offset(10)
        }
    }
    
    
}

extension HomeDetailViewViewController: UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        whiteView.layer.cornerRadius = 30
        whiteView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        whiteView.clipsToBounds = true
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sortedGroupedArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sortedGroupedArray = sortedGroupedArray {
            return sortedGroupedArray[section].values.first?.count ?? 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sortedGroupedArray?[section].keys.first
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        if let itemsInSection = sortedGroupedArray?[indexPath.section].values.first {
                let item = itemsInSection[indexPath.row]
                cell.textLabel?.text = item["type"] // 或其他字段
            }
        return cell
    }
    
}

