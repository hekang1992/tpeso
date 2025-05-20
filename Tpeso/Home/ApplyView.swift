//
//  ApplyView.swift
//  Tpeso
//
//  Created by 何康 on 2025/5/19.
//

import UIKit
import IQTextView

class ApplyView: BaseView {
    
    var leftBlock: ((UILabel) -> Void)?
    var rightBlock: ((UILabel) -> Void)?

    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .white
        bgView.layer.cornerRadius = 30
        bgView.layer.masksToBounds = true
        return bgView
    }()
    
    lazy var completBtn: UIButton = {
        let completBtn = UIButton(type: .custom)
        completBtn.setTitle("complete", for: .normal)
        completBtn.titleLabel?.font = .regularFontOfSize(size: 13)
        completBtn.backgroundColor = UIColor("#FFB12A")
        completBtn.layer.cornerRadius = 14
        completBtn.layer.masksToBounds = true
        completBtn.setTitleColor(.white, for: .normal)
        return completBtn
    }()
    
    lazy var mlabel: UILabel = {
        let mlabel = UILabel()
        mlabel.text = "Program Name"
        mlabel.textColor = UIColor("#333333")
        mlabel.textAlignment = .left
        mlabel.font = .regularFontOfSize(size: 13)
        return mlabel
    }()
    
    lazy var oneView: UIView = {
        let oneView = UIView()
        oneView.backgroundColor = UIColor("#F7F7F7")
        oneView.layer.cornerRadius = 20
        oneView.layer.masksToBounds = true
        oneView.layer.borderWidth = 1
        oneView.layer.borderColor = UIColor("#EEEEEE").cgColor
        return oneView
    }()
    
    lazy var phoneTx: UITextField = {
        let phoneTx = UITextField()
        phoneTx.keyboardType = .default
        let attrString = NSMutableAttributedString(string: "Enter a plan name", attributes: [
            .foregroundColor: UIColor("#666666") as Any,
            .font: UIFont.regularFontOfSize(size: 14)
        ])
        phoneTx.attributedPlaceholder = attrString
        phoneTx.font = .regularFontOfSize(size: 14)
        phoneTx.textColor = UIColor("#333333")
        return phoneTx
    }()
    
    lazy var addlabel: UILabel = {
        let addlabel = UILabel()
        addlabel.text = "Add budget"
        addlabel.textColor = UIColor("#333333")
        addlabel.textAlignment = .left
        addlabel.font = .regularFontOfSize(size: 13)
        return addlabel
    }()
    
    lazy var addView: UIView = {
        let addView = UIView()
        addView.backgroundColor = UIColor("#F7F7F7")
        addView.layer.cornerRadius = 20
        addView.layer.masksToBounds = true
        addView.layer.borderWidth = 1
        addView.layer.borderColor = UIColor("#EEEEEE").cgColor
        return addView
    }()
    
    lazy var addTx: UITextField = {
        let addTx = UITextField()
        addTx.keyboardType = .numberPad
        let attrString = NSMutableAttributedString(string: "₱ Enter your budget", attributes: [
            .foregroundColor: UIColor("#666666") as Any,
            .font: UIFont.regularFontOfSize(size: 14)
        ])
        addTx.attributedPlaceholder = attrString
        addTx.font = .regularFontOfSize(size: 14)
        addTx.textColor = UIColor("#333333")
        return addTx
    }()
    
    lazy var endlabel: UILabel = {
        let endlabel = UILabel()
        endlabel.text = "Start and end time"
        endlabel.textColor = UIColor("#333333")
        endlabel.textAlignment = .left
        endlabel.font = .regularFontOfSize(size: 13)
        return endlabel
    }()
    
    lazy var leftlabel: UILabel = {
        let leftlabel = UILabel()
        leftlabel.text = "Select start time"
        leftlabel.textColor = UIColor("#666666")
        leftlabel.textAlignment = .center
        leftlabel.font = .regularFontOfSize(size: 13)
        leftlabel.layer.cornerRadius = 20
        leftlabel.layer.masksToBounds = true
        leftlabel.backgroundColor = UIColor("#F7F7F7")
        leftlabel.isUserInteractionEnabled = true
        return leftlabel
    }()
    
    lazy var rightlabel: UILabel = {
        let rightlabel = UILabel()
        rightlabel.text = "Select end time"
        rightlabel.textColor = UIColor("#666666")
        rightlabel.textAlignment = .center
        rightlabel.font = .regularFontOfSize(size: 13)
        rightlabel.layer.cornerRadius = 20
        rightlabel.layer.masksToBounds = true
        rightlabel.backgroundColor = UIColor("#F7F7F7")
        rightlabel.isUserInteractionEnabled = true
        return rightlabel
    }()
    
    lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor("#21CEA1")
        return lineView
    }()
    
    lazy var desclabel: UILabel = {
        let desclabel = UILabel()
        desclabel.text = "Record"
        desclabel.textColor = UIColor("#333333")
        desclabel.textAlignment = .left
        desclabel.font = .regularFontOfSize(size: 13)
        return desclabel
    }()
    
    lazy var descView: UIView = {
        let descView = UIView()
        descView.layer.cornerRadius = 18
        descView.layer.masksToBounds = true
        descView.backgroundColor = UIColor("#F7F7F7")
        descView.layer.borderWidth = 1
        descView.layer.borderColor = UIColor("#EEEEEE").cgColor
        return descView
    }()
    
    lazy var writeView: IQTextView = {
        let writeView = IQTextView()
        writeView.placeholder = "Record future itineraries and locations for easy viewing while traveling"
        writeView.placeholderLabel.font = .regularFontOfSize(size: 13)
        writeView.placeholderTextColor = .lightGray
        writeView.backgroundColor = .clear
        writeView.textColor = .black
        return writeView
    }()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "comlegeimage")
        return bgImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
        bgView.addSubview(completBtn)
        bgView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.left.equalToSuperview().offset(12)
            make.height.equalTo(547)
        }
        completBtn.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 70, height: 28))
            make.top.equalToSuperview().offset(18)
            make.right.equalToSuperview().offset(-18)
        }
        bgView.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
            make.left.equalToSuperview()
            make.height.equalTo(202)
        }
        
        bgView.addSubview(mlabel)
        bgView.addSubview(oneView)
        mlabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(53)
            make.left.equalToSuperview().offset(17)
            make.size.equalTo(CGSize(width: 200, height: 18))
        }
        oneView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(mlabel.snp.bottom).offset(7)
            make.left.equalToSuperview().offset(17)
            make.height.equalTo(40)
        }
        
        oneView.addSubview(phoneTx)
        phoneTx.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.bottom.top.equalToSuperview()
            make.right.equalToSuperview().offset(-15)
        }
        
        bgView.addSubview(addlabel)
        bgView.addSubview(addView)
        addView.addSubview(addTx)
        
        addlabel.snp.makeConstraints { make in
            make.top.equalTo(oneView.snp.bottom).offset(9)
            make.left.equalToSuperview().offset(17)
            make.size.equalTo(CGSize(width: 200, height: 18))
        }
        addView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(addlabel.snp.bottom).offset(7)
            make.left.equalToSuperview().offset(17)
            make.height.equalTo(40)
        }
        addTx.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.bottom.top.equalToSuperview()
            make.right.equalToSuperview().offset(-15)
        }
        
        bgView.addSubview(endlabel)
        endlabel.snp.makeConstraints { make in
            make.top.equalTo(addView.snp.bottom).offset(9)
            make.left.equalToSuperview().offset(17)
            make.size.equalTo(CGSize(width: 200, height: 18))
        }
        
        bgView.addSubview(leftlabel)
        leftlabel.snp.makeConstraints { make in
            make.top.equalTo(endlabel.snp.bottom).offset(7)
            make.left.equalToSuperview().offset(17)
            make.size.equalTo(CGSize(width: 140, height: 40))
        }
        bgView.addSubview(rightlabel)
        rightlabel.snp.makeConstraints { make in
            make.top.equalTo(endlabel.snp.bottom).offset(7)
            make.right.equalToSuperview().offset(-17)
            make.size.equalTo(CGSize(width: 140, height: 40))
        }
        
        bgView.addSubview(lineView)
        lineView.snp.makeConstraints { make in
            make.centerY.equalTo(leftlabel.snp.centerY)
            make.left.equalTo(leftlabel.snp.right).offset(8)
            make.right.equalTo(rightlabel.snp.left).offset(-8)
            make.height.equalTo(1)
        }
        
        bgView.addSubview(desclabel)
        desclabel.snp.makeConstraints { make in
            make.top.equalTo(rightlabel.snp.bottom).offset(9)
            make.left.equalToSuperview().offset(17)
            make.size.equalTo(CGSize(width: 200, height: 18))
        }
        
        bgView.addSubview(descView)
        descView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(17)
            make.centerX.equalToSuperview()
            make.top.equalTo(desclabel.snp.bottom).offset(7)
            make.height.equalTo(108)
        }
        descView.addSubview(writeView)
        writeView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(9)
            make.left.equalToSuperview().offset(15)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
        }
        
        leftlabel.rx.tapGesture().when(.recognized).subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            self.leftBlock?(leftlabel)
        }).disposed(by: disposeBag)
        
        rightlabel.rx.tapGesture().when(.recognized).subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            self.rightBlock?(rightlabel)
        }).disposed(by: disposeBag)
        
        
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
