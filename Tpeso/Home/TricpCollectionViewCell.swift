//
//  TricpCollectionViewCell.swift
//  Tpeso
//
//  Created by tom on 2025/5/21.
//

import UIKit

class TricpCollectionViewCell: UICollectionViewCell {
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.layer.cornerRadius = 15
        logoImageView.layer.masksToBounds = true
        return logoImageView
    }()
    
    lazy var desc1Label: UILabel = {
        let desc1Label = UILabel()
        desc1Label.textColor = UIColor("#333333")
        desc1Label.font = .regularFontOfSize(size: 14)
        desc1Label.textAlignment = .center
        return desc1Label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(logoImageView)
        addSubview(desc1Label)
        
        logoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 60, height: 60))
            make.top.equalToSuperview().offset(10)
        }
        desc1Label.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.height.equalTo(15)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
