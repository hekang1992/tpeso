//
//  SureDeleteTricpView.swift
//  Tpeso
//
//  Created by 何康 on 2025/7/14.
//

import UIKit

class SureDeleteTricpView: BaseView {

    var block: (() -> Void)?
    var block1: (() -> Void)?
    
    
    lazy var imge: UIImageView = {
        let imge = UIImageView()
        imge.isUserInteractionEnabled = true
        imge.image = UIImage(named: "aler_igme_a")
        return imge
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Confirm to end this travel plan account in advance？"
        titleLabel.numberOfLines = 2
        titleLabel.textColor = UIColor.gray
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.textAlignment = .center
        return titleLabel
    }()
    
    lazy var cancelBtn: UIButton = {
        let cancelBtn = UIButton(type: .custom)
        cancelBtn.setTitle("Cancel", for: .normal)
        cancelBtn.setTitleColor(.white, for: .normal)
        cancelBtn.backgroundColor = UIColor("#FFB12A")
        cancelBtn.layer.cornerRadius = 20
        return cancelBtn
    }()
    
    lazy var sureBtn: UIButton = {
        let sureBtn = UIButton(type: .custom)
        sureBtn.setTitle("Sure", for: .normal)
        sureBtn.setTitleColor(.white, for: .normal)
        sureBtn.backgroundColor = UIColor("#80A51C")
        sureBtn.layer.cornerRadius = 20
        return sureBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imge)
        imge.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 339, height: 203))
        }
        
        imge.addSubview(titleLabel)
        imge.addSubview(cancelBtn)
        imge.addSubview(sureBtn)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(26)
            make.height.equalTo(40)
        }
        
        cancelBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(30)
            make.bottom.equalToSuperview().offset(-30)
            make.size.equalTo(CGSize(width: 120, height: 45))
        }
        
        sureBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-30)
            make.bottom.equalToSuperview().offset(-30)
            make.size.equalTo(CGSize(width: 120, height: 45))
        }
        
        
        cancelBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.block?()
        }).disposed(by: disposeBag)
        
        sureBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.block1?()
        }).disposed(by: disposeBag)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
