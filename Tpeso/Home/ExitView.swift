//
//  ExitView.swift
//  Tpeso
//
//  Created by 何康 on 2025/5/20.
//

import UIKit

class ExitView: BaseView {
    
    var block: (() -> Void)?
    var block1: (() -> Void)?
    
    
    lazy var imge: UIImageView = {
        let imge = UIImageView()
        imge.isUserInteractionEnabled = true
        return imge
    }()
    
    lazy var cancelBtn: UIButton = {
        let cancelBtn = UIButton(type: .custom)
        return cancelBtn
    }()
    
    lazy var sureBtn: UIButton = {
        let sureBtn = UIButton(type: .custom)
        return sureBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imge)
        imge.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 339, height: 203))
        }
        
        imge.addSubview(cancelBtn)
        imge.addSubview(sureBtn)
        
        cancelBtn.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.bottom.equalToSuperview()
            make.size.equalTo(CGSize(width: 170, height: 90))
        }
        
        sureBtn.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.size.equalTo(CGSize(width: 170, height: 90))
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
