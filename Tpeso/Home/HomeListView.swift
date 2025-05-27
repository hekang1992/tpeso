//
//  HomeListView.swift
//  Tpeso
//
//  Created by tom on 2025/5/26.
//

import UIKit

class HomeListView: BaseView {
    
    var block: (() -> Void)?
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .white
        bgView.layer.cornerRadius = 36
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

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.size.equalTo(CGSize(width: 365, height: 72))
            make.centerX.equalToSuperview()
        }
        bgView.addSubview(imgerView)
        bgView.addSubview(nameLabel)
        imgerView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.size.equalTo(CGSize(width: 52, height: 52))
        }
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(imgerView.snp.right).offset(12)
            make.height.equalTo(30)
        }
        
        self.isUserInteractionEnabled = true
        self.rx.tapGesture().when(.recognized).subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            self.block?()
        }).disposed(by: disposeBag)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
