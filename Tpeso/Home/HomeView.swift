//
//  Home.swift
//  Tpeso
//
//  Created by 何康 on 2025/5/19.
//

import UIKit

class HomeView: BaseView {
    
    lazy var footerImageView: UIImageView = {
        let footerImageView = UIImageView()
        footerImageView.image = UIImage(named: "homebgimge")
        return footerImageView
    }()
    
    lazy var welcomeImageView: UIImageView = {
        let welcomeImageView = UIImageView()
        welcomeImageView.image = UIImage(named: "welcomeimge")
        return welcomeImageView
    }()
    
    lazy var centerImageView: UIImageView = {
        let centerImageView = UIImageView()
        centerImageView.image = UIImage(named: "imagehome")
        return centerImageView
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .white
        return bgView
    }()
    
    lazy var greenView: UIView = {
        let greenView = UIView()
        greenView.backgroundColor = UIColor("#C4E961")
        return greenView
    }()
    
    lazy var birdImageView: UIImageView = {
        let birdImageView = UIImageView()
        birdImageView.image = UIImage(named: "birdimge")
        return birdImageView
    }()
    
    lazy var applyBtn: UIButton = {
        let applyBtn = UIButton(type: .custom)
        applyBtn.setTitle("Add travel plan", for: .normal)
        applyBtn.backgroundColor = UIColor("#FFB12A")
        applyBtn.titleLabel?.font = .boldFontOfSize(size: 16)
        applyBtn.layer.borderWidth = 1
        applyBtn.layer.borderColor = UIColor.white.cgColor
        applyBtn.layer.cornerRadius = 25
        return applyBtn
    }()
    
    lazy var settingBtn: UIButton = {
        let settingBtn = UIButton(type: .custom)
        settingBtn.setImage(UIImage(named: "graeimge"), for: .normal)
        return settingBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor("#C4E961")
        
        addSubview(welcomeImageView)
        addSubview(bgView)
        bgView.addSubview(centerImageView)
        welcomeImageView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(15)
            make.size.equalTo(CGSize(width: 177, height: 54))
            make.left.equalToSuperview().offset(14)
        }
        bgView.snp.makeConstraints { make in
            make.top.equalTo(welcomeImageView.snp.bottom).offset(24)
            make.left.right.bottom.equalToSuperview()
        }
        centerImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(25)
            make.size.equalTo(CGSize(width: 375, height: 181))
        }
        
        bgView.addSubview(greenView)
        greenView.addSubview(footerImageView)
        greenView.snp.makeConstraints { make in
            make.top.equalTo(centerImageView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        footerImageView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
            make.size.equalTo(CGSize(width: 375, height: 240))
        }
        
        greenView.addSubview(birdImageView)
        birdImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(24)
            make.size.equalTo(CGSize(width: 305, height: 93))
        }
        
        greenView.addSubview(applyBtn)
        applyBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(birdImageView.snp.bottom).offset(19)
            make.size.equalTo(CGSize(width: 302, height: 49))
        }
    
        addSubview(settingBtn)
        settingBtn.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(10)
            make.right.equalToSuperview().offset(-20)
            make.size.equalTo(CGSize(width: 22, height: 22))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension HomeView {
    
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
