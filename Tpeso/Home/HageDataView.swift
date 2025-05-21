//
//  HageDataView.swift
//  Tpeso
//
//  Created by 何康 on 2025/5/20.
//

import UIKit

class HageDataView: BaseView {
    
    var block: ((UIButton) -> Void)?
    var editblock: ((UIButton) -> Void)?
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "Current trip"
        nameLabel.textColor = UIColor("#253204")
        nameLabel.textAlignment = .center
        nameLabel.font = .boldFontOfSize(size: 18)
        return nameLabel
    }()
    
    lazy var settingBtn: UIButton = {
        let settingBtn = UIButton(type: .custom)
        settingBtn.setImage(UIImage(named: "graeimge"), for: .normal)
        return settingBtn
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .white
        return bgView
    }()
    
    lazy var ctImageView: UIImageView = {
        let ctImageView = UIImageView()
        ctImageView.image = UIImage(named: "birdtwoimge")
        return ctImageView
    }()
    
    lazy var tnameLabel: UILabel = {
        let tnameLabel = UILabel()
        tnameLabel.textColor = .black
        tnameLabel.textAlignment = .left
        tnameLabel.font = .boldFontOfSize(size: 20)
        return tnameLabel
    }()
    
    lazy var changeBtn: UIButton = {
        let changeBtn = UIButton(type: .custom)
        changeBtn.setImage(UIImage(named: "chagnebtn"), for: .normal)
        return changeBtn
    }()
    
    lazy var treeImageView: UIImageView = {
        let treeImageView = UIImageView()
        treeImageView.image = UIImage(named: "treeimge")
        return treeImageView
    }()
    
    lazy var moreBtn: UIButton = {
        let moreBtn = UIButton(type: .custom)
        moreBtn.setImage(UIImage(named: "morepointimge"), for: .normal)
        return moreBtn
    }()
    
    lazy var icon1: UIImageView = {
        let icon1 = UIImageView()
        icon1.image = UIImage(named: "dateimgeir")
        return icon1
    }()
    
    lazy var icon2: UIImageView = {
        let icon2 = UIImageView()
        icon2.image = UIImage(named: "mongimgehom")
        return icon2
    }()
    
    lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor("#EBEBEB")
        return lineView
    }()
    
    lazy var timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.textAlignment = .left
        timeLabel.textColor = UIColor("#666666")
        timeLabel.font = .regularFontOfSize(size: 14)
        return timeLabel
    }()
    
    lazy var timedescLabel: UILabel = {
        let timedescLabel = UILabel()
        timedescLabel.textAlignment = .left
        timedescLabel.textColor = UIColor("#666666")
        timedescLabel.font = .regularFontOfSize(size: 14)
        return timedescLabel
    }()
    
    lazy var moneyLabel: UILabel = {
        let moneyLabel = UILabel()
        moneyLabel.textAlignment = .left
        moneyLabel.textColor = UIColor("#000000")
        moneyLabel.font = .boldFontOfSize(size: 20)
        return moneyLabel
    }()
    
    lazy var moneydescLabel: UILabel = {
        let moneydescLabel = UILabel()
        moneydescLabel.textAlignment = .left
        moneydescLabel.textColor = UIColor("#666666")
        moneydescLabel.text = "Budget surplus"
        moneydescLabel.font = .regularFontOfSize(size: 14)
        return moneydescLabel
    }()
    
    lazy var progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.layer.cornerRadius = 5
        progressView.layer.masksToBounds = true
        progressView.progressTintColor = UIColor("#80A51C")
        progressView.trackTintColor = UIColor("#C4E961")
        return progressView
    }()
    
    lazy var minLabel: UILabel = {
        let minLabel = UILabel()
        minLabel.text = "10,000₱"
        minLabel.textColor = UIColor("#666666")
        minLabel.textAlignment = .left
        minLabel.font = .boldFontOfSize(size: 10)
        return minLabel
    }()
    
    lazy var maxLabel: UILabel = {
        let maxLabel = UILabel()
        maxLabel.text = "50,000₱"
        maxLabel.textColor = UIColor("#666666")
        maxLabel.textAlignment = .right
        maxLabel.font = .boldFontOfSize(size: 10)
        return maxLabel
    }()
    
    lazy var greenView: UIView = {
        let greenView = UIView()
        greenView.backgroundColor = UIColor("#C4E961")
        return greenView
    }()
    
    lazy var sureBtn: UIButton = {
        let sureBtn = UIButton(type: .custom)
        sureBtn.setTitle("End of the journey", for: .normal)
        sureBtn.backgroundColor = UIColor("#FFB12A")
        sureBtn.layer.cornerRadius = 25
        sureBtn.layer.masksToBounds = true
        sureBtn.titleLabel?.font = .boldFontOfSize(size: 16)
        return sureBtn
    }()
    
    lazy var editBtn: UIButton = {
        let editBtn = UIButton(type: .custom)
        editBtn.setImage(UIImage(named: "eidmigepancel"), for: .normal)
        return editBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor("#C4E961")
        addSubview(nameLabel)
        addSubview(settingBtn)
        addSubview(bgView)
        addSubview(ctImageView)
        bgView.addSubview(tnameLabel)
        bgView.addSubview(changeBtn)
        bgView.addSubview(treeImageView)
        bgView.addSubview(moreBtn)
        bgView.addSubview(progressView)
        bgView.addSubview(minLabel)
        bgView.addSubview(maxLabel)
        greenView.addSubview(editBtn)
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(10)
            make.height.equalTo(20)
        }
        settingBtn.snp.makeConstraints { make in
            make.centerY.equalTo(nameLabel.snp.centerY)
            make.right.equalToSuperview().offset(-20)
            make.size.equalTo(CGSize(width: 22, height: 22))
        }
        bgView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(47)
            make.left.right.bottom.equalToSuperview()
        }
        ctImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.size.equalTo(CGSize(width: 315, height: 56))
        }
        tnameLabel.snp.makeConstraints { make in
            make.height.equalTo(22)
            make.top.equalToSuperview().offset(30)
            make.left.equalToSuperview().offset(18)
        }
        changeBtn.snp.makeConstraints { make in
            make.centerY.equalTo(tnameLabel.snp.centerY)
            make.left.equalTo(tnameLabel.snp.right).offset(9)
            make.size.equalTo(CGSize(width: 15, height: 15))
        }
        treeImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(8)
            make.top.equalTo(tnameLabel.snp.bottom).offset(15)
            make.size.equalTo(CGSize(width: 136, height: 146))
        }
        moreBtn.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 21, height: 21))
            make.centerY.equalTo(changeBtn.snp.centerY)
            make.right.equalToSuperview().offset(-40)
        }
        
        bgView.addSubview(icon1)
        icon1.snp.makeConstraints { make in
            make.top.equalTo(treeImageView.snp.top).offset(20)
            make.left.equalTo(treeImageView.snp.right).offset(23)
            make.size.equalTo(CGSize(width: 22, height: 22))
        }
        
        bgView.addSubview(lineView)
        lineView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(icon1.snp.bottom).offset(30)
            make.right.equalToSuperview().offset(-40)
            make.left.equalTo(treeImageView.snp.right).offset(23)
        }
        
        bgView.addSubview(icon2)
        icon2.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(30)
            make.left.equalTo(treeImageView.snp.right).offset(23)
            make.size.equalTo(CGSize(width: 22, height: 22))
        }
        
        bgView.addSubview(timeLabel)
        bgView.addSubview(timedescLabel)
        
        timeLabel.snp.makeConstraints { make in
            make.height.equalTo(25)
            make.left.equalTo(icon1.snp.right).offset(10)
            make.top.equalTo(treeImageView.snp.top)
        }
        timedescLabel.snp.makeConstraints { make in
            make.height.equalTo(25)
            make.left.equalTo(icon1.snp.right).offset(10)
            make.top.equalTo(timeLabel.snp.bottom)
        }
        
        bgView.addSubview(moneyLabel)
        bgView.addSubview(moneydescLabel)
        
        moneyLabel.snp.makeConstraints { make in
            make.height.equalTo(25)
            make.left.equalTo(icon2.snp.right).offset(10)
            make.top.equalTo(lineView.snp.top).offset(19)
        }
        moneydescLabel.snp.makeConstraints { make in
            make.height.equalTo(25)
            make.left.equalTo(icon2.snp.right).offset(10)
            make.top.equalTo(moneyLabel.snp.bottom)
        }
        
        bgView.addSubview(progressView)
        progressView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(40)
            make.centerX.equalToSuperview()
            make.height.equalTo(8)
            make.top.equalTo(treeImageView.snp.bottom).offset(20)
        }
        
        minLabel.snp.makeConstraints { make in
            make.left.equalTo(progressView.snp.left)
            make.top.equalTo(progressView.snp.bottom).offset(1)
            make.height.equalTo(12)
        }
        maxLabel.snp.makeConstraints { make in
            make.right.equalTo(progressView.snp.right)
            make.top.equalTo(progressView.snp.bottom).offset(1)
            make.height.equalTo(12)
        }
        
        bgView.addSubview(greenView)
        greenView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(progressView.snp.bottom).offset(50)
        }
        
        bgView.addSubview(sureBtn)
        sureBtn.snp.makeConstraints { make in
            make.top.equalTo(greenView.snp.top).offset(-27)
            make.height.equalTo(54)
            make.centerX.equalToSuperview()
            make.left.equalTo(40)
        }
        
        editBtn.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 80, height: 80))
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.right.equalToSuperview().offset(-20)
        }
        
        moreBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.block?(moreBtn)
        }).disposed(by: disposeBag)
        
        editBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.editblock?(editBtn)
        }).disposed(by: disposeBag)
        
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension HageDataView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bgView.layer.cornerRadius = 30
        bgView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        bgView.clipsToBounds = true
        
        greenView.layer.cornerRadius = 30
        greenView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        greenView.clipsToBounds = true
    }
}

