//
//  NOViewCell.swift
//  Tpeso
//
//  Created by 何康 on 2025/5/26.
//

import UIKit

class NoViewCell: BaseViewCell {
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = UIColor("#F7FCFF")
        bgView.layer.cornerRadius = 20
        bgView.layer.masksToBounds = true
        return bgView
    }()
    
    lazy var imgerView: UIImageView = {
        let imgerView = UIImageView()
        imgerView.image = UIImage(named: "setimgeicon")
        imgerView.layer.cornerRadius = 26
        imgerView.layer.masksToBounds = true
        return imgerView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = .black
        nameLabel.font = .regularFontOfSize(size: 17)
        nameLabel.textAlignment = .left
        return nameLabel
    }()
    
    lazy var timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.textColor = UIColor("#999999")
        timeLabel.font = .regularFontOfSize(size: 12)
        timeLabel.textAlignment = .left
        return timeLabel
    }()
    
    lazy var moneyLabel: UILabel = {
        let moneyLabel = UILabel()
        moneyLabel.textColor = .black
        moneyLabel.font = .boldFontOfSize(size: 20)
        moneyLabel.textAlignment = .right
        return moneyLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(bgView)
        contentView.addSubview(imgerView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(moneyLabel)
        
        bgView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.size.equalTo(CGSize(width: 365, height: 72))
            make.centerX.equalToSuperview()
        }
        
        imgerView.snp.makeConstraints { make in
            make.centerY.equalTo(bgView)
            make.left.equalToSuperview().offset(35)
            make.size.equalTo(CGSize(width: 52, height: 52))
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(9)
            make.left.equalTo(imgerView.snp.right).offset(12)
            make.height.equalTo(27)
        }
        timeLabel.snp.makeConstraints { make in
            make.bottom.equalTo(imgerView.snp.bottom)
            make.left.equalTo(nameLabel.snp.left)
            make.height.equalTo(15)
            make.bottom.equalToSuperview().offset(-20)
        }
        moneyLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-25)
            make.height.equalTo(30)
        }
        
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
