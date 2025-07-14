//
//  ChangeTricpView.swift
//  Tpeso
//
//  Created by 何康 on 2025/7/14.
//

import UIKit

class ChangeTricpView: BaseView {
    
    var selectedIndexPath: IndexPath?
    
    var saveTricpArray: [PlaneModel]?
    
    var completeBlock: ((String, Int) -> Void)?
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .white
        bgView.layer.cornerRadius = 20
        return bgView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.register(DescCell.self, forCellReuseIdentifier: "DescCell")
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.delegate = self
        tableView.dataSource = self
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        return tableView
    }()
    
    lazy var completeBtn: UIButton = {
        let completeBtn = UIButton()
        completeBtn.setTitle("Complete", for: .normal)
        completeBtn.setTitleColor(.white, for: .normal)
        completeBtn.backgroundColor = UIColor("#FFB12A")
        completeBtn.layer.cornerRadius = 20
        return completeBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(360)
        }
        
        bgView.addSubview(completeBtn)
        completeBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
            make.size.equalTo(CGSize(width: 334, height: 54))
        }
        
        bgView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(completeBtn.snp.top).offset(-20)
        }
        
        completeBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self, let selectedIndexPath = selectedIndexPath  else { return }
            let model = saveTricpArray?[selectedIndexPath.row]
            self.completeBlock?(model?.title ?? "", selectedIndexPath.row)
        }).disposed(by: disposeBag)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ChangeTricpView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return saveTricpArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = saveTricpArray?[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "DescCell", for: indexPath) as! DescCell
        cell.titleLabel.text = model?.title ?? ""
        if indexPath == selectedIndexPath {
            cell.bgView.backgroundColor = UIColor("#C4E961")
        } else {
            cell.bgView.backgroundColor = UIColor("#F7F7F7")
        }
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedIndexPath = selectedIndexPath {
            if let previousCell = tableView.cellForRow(at: selectedIndexPath) as? DescCell {
                previousCell.bgView.backgroundColor = UIColor("#F7F7F7")
            }
        }
        
        if let cell = tableView.cellForRow(at: indexPath) as? DescCell {
            cell.bgView.backgroundColor = UIColor("#C4E961")
        }
        
        selectedIndexPath = indexPath
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}


class DescCell: UITableViewCell {
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = UIColor("#F7F7F7")
        bgView.layer.cornerRadius = 10
        return bgView
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor("#333333")
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.textAlignment = .center
        return titleLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(bgView)
        bgView.addSubview(titleLabel)
        
        bgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
            make.size.equalTo(CGSize(width: 334, height: 40))
        }
        
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 300, height: 40))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
