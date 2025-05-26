//
//  TCameraView.swift
//  Tpeso
//
//  Created by tom on 2025/5/21.
//

import UIKit

class TCameraView: BaseView {
    
    var block1: (() -> Void)?
    var block2: (() -> Void)?
    var block3: (() -> Void)?

    lazy var ctImageView: UIImageView = {
        let ctImageView = UIImageView()
        ctImageView.isUserInteractionEnabled = true
        ctImageView.image = UIImage(named: "imgeuiphoto")
        return ctImageView
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .white
        return bgView
    }()
    
    lazy var oneBtn: UIButton = {
        let oneBtn = UIButton(type: .custom)
        return oneBtn
    }()
    
    lazy var twoBtn: UIButton = {
        let twoBtn = UIButton(type: .custom)
        return twoBtn
    }()
    
    lazy var threeBtn: UIButton = {
        let threeBtn = UIButton(type: .custom)
        return threeBtn
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
        bgView.addSubview(ctImageView)
        ctImageView.addSubview(oneBtn)
        ctImageView.addSubview(twoBtn)
        ctImageView.addSubview(threeBtn)
        bgView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(255)
        }
        ctImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(40)
            make.size.equalTo(CGSize(width: 334, height: 173))
        }
        oneBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.height.equalTo(40)
        }
        twoBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(oneBtn.snp.bottom).offset(12)
            make.left.equalToSuperview()
            make.height.equalTo(40)
        }
        threeBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(twoBtn.snp.bottom).offset(27)
            make.left.equalToSuperview()
            make.height.equalTo(54)
        }
        
        oneBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.block1?()
        }).disposed(by: disposeBag)
        
        twoBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.block2?()
        }).disposed(by: disposeBag)
        
        threeBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.block3?()
        }).disposed(by: disposeBag)
        
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension TCameraView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bgView.layer.cornerRadius = 30
        bgView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        bgView.clipsToBounds = true
    }
    
}
