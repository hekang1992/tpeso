//
//  TricpView.swift
//  Tpeso
//
//  Created by tom on 2025/5/21.
//

import UIKit

class TricpView: BaseView {
    
    var selectedIndexPath: IndexPath? = nil
    
    let imageArray = ["Transportation", "Hotel", "Food", "Tickets", "Shopping", "Entertainment", "Tour Fee", "Other", "Photograph"]
    
    var block: ((UIButton) -> Void)?
    var camerablock: ((UIButton) -> Void)?
    var completeblock: (() -> Void)?
    
    var type: String = ""
    
    var imagebase: String = ""
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .white
        return bgView
    }()
    
    lazy var descLabel: UILabel = {
        let descLabel = UILabel()
        descLabel.text = "Consumption amount"
        descLabel.font = .regularFontOfSize(size: 18)
        descLabel.textAlignment = .left
        return descLabel
    }()
    
    lazy var moneyTx: UITextField = {
        let moneyTx = UITextField()
        moneyTx.keyboardType = .numberPad
        let attrString = NSMutableAttributedString(string: "₱ Enter your budget", attributes: [
            .foregroundColor: UIColor("#666666") as Any,
            .font: UIFont.regularFontOfSize(size: 20)
        ])
        moneyTx.attributedPlaceholder = attrString
        moneyTx.font = .regularFontOfSize(size: 20)
        moneyTx.textColor = UIColor("#333333")
        return moneyTx
    }()
    
    lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor("#EBEBEB")
        return lineView
    }()
    
    lazy var cameraBtn: UIButton = {
        let cameraBtn = UIButton(type: .custom)
        cameraBtn.setImage(UIImage(named: "cameagigme"), for: .normal)
        cameraBtn.layer.cornerRadius = 22
        cameraBtn.layer.masksToBounds = true
        return cameraBtn
    }()
    
    lazy var cycleView: UIView = {
        let cycleView = UIView()
        cycleView.backgroundColor = UIColor("#F7F7F7")
        cycleView.layer.borderWidth = 1
        cycleView.layer.borderColor = UIColor("#EEEEEE").cgColor
        cycleView.layer.cornerRadius = 20
        cycleView.layer.masksToBounds = true
        return cycleView
    }()
    
    lazy var timeBtn: UIButton = {
        let timeBtn = UIButton(type: .custom)
        timeBtn.setImage(UIImage(named: "dateimgeir"), for: .normal)
        timeBtn.titleLabel?.font = .regularFontOfSize(size: 14)
        timeBtn.setTitle("Choose a time", for: .normal)
        timeBtn.setTitleColor(UIColor("#666666"), for: .normal)
        timeBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        timeBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        return timeBtn
    }()
    
    lazy var desc1Label: UILabel = {
        let desc1Label = UILabel()
        desc1Label.text = "Consumption Type"
        desc1Label.font = .regularFontOfSize(size: 18)
        desc1Label.textAlignment = .left
        return desc1Label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.itemSize = CGSize(width: 100, height: 100)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TricpCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    lazy var applyBtn: UIButton = {
        let applyBtn = UIButton(type: .custom)
        applyBtn.setTitle("Complete", for: .normal)
        applyBtn.backgroundColor = UIColor("#FFB12A")
        applyBtn.titleLabel?.font = .boldFontOfSize(size: 16)
        applyBtn.layer.borderWidth = 1
        applyBtn.layer.borderColor = UIColor.white.cgColor
        applyBtn.layer.cornerRadius = 25
        return applyBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
        bgView.addSubview(descLabel)
        bgView.addSubview(moneyTx)
        bgView.addSubview(lineView)
        bgView.addSubview(cameraBtn)
        bgView.addSubview(cycleView)
        cycleView.addSubview(timeBtn)
        bgView.addSubview(desc1Label)
        bgView.addSubview(collectionView)
        bgView.addSubview(applyBtn)
        bgView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(667)
        }
        descLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.top.equalToSuperview().offset(40)
            make.left.equalToSuperview().offset(40)
        }
        moneyTx.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(72)
            make.left.equalToSuperview().offset(40)
            make.size.equalTo(CGSize(width: 300, height: 30))
        }
        lineView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(40)
            make.centerX.equalToSuperview()
            make.top.equalTo(moneyTx.snp.bottom).offset(10)
            make.height.equalTo(2)
        }
        cameraBtn.snp.makeConstraints { make in
            make.centerY.equalTo(moneyTx.snp.centerY)
            make.right.equalToSuperview().offset(-30)
            make.size.equalTo(CGSize(width: 44, height: 44))
        }
        cycleView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(40)
            make.height.equalTo(40)
            make.top.equalTo(lineView.snp.bottom).offset(24)
        }
        timeBtn.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        desc1Label.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.top.equalTo(timeBtn.snp.bottom).offset(24)
            make.left.equalToSuperview().offset(40)
        }
        
        collectionView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(40)
            make.top.equalTo(desc1Label.snp.bottom).offset(18)
            make.height.equalTo(320)
        }
        
        applyBtn.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 334, height: 54))
        }
        
        cameraBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.camerablock?(cameraBtn)
        }).disposed(by: disposeBag)
        
        timeBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.block?(timeBtn)
        }).disposed(by: disposeBag)
        
        applyBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.completeblock?()
        }).disposed(by: disposeBag)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension TricpView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bgView.layer.cornerRadius = 30
        bgView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        bgView.clipsToBounds = true
    }
    
}

extension TricpView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TricpCollectionViewCell
        let imgename = imageArray[indexPath.row]
        cell.logoImageView.image = UIImage(named: imgename)
        cell.desc1Label.text = imgename
        
        if indexPath == selectedIndexPath {
            cell.logoImageView.layer.borderWidth = 2
            cell.logoImageView.layer.borderColor = UIColor.black.cgColor
        } else {
            cell.logoImageView.layer.borderWidth = 2
            cell.logoImageView.layer.borderColor = UIColor.clear.cgColor
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        let imgename = imageArray[indexPath.row]
        type = imgename
        collectionView.reloadData()
    }
    
}
