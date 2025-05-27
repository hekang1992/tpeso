//
//  YesViewCell.swift
//  Tpeso
//
//  Created by tom on 2025/5/26.
//

import UIKit

class YesViewCell: BaseViewCell {
    
    var modelArray: [String]? {
        didSet {
            guard let modelArray = modelArray else { return }
            
            // 1. 清空 scrollView 之前的子视图
            scrollView.subviews.forEach { $0.removeFromSuperview() }
            
            // 2. 动态添加 UIImageView
            var previousImageView: UIImageView?
            let imageSize = CGSize(width: 65, height: 65) // 图片大小
            let spacing: CGFloat = 5 // 图片间距
            
            for (index, item) in modelArray.enumerated() {
                let imageView = UIImageView()
                imageView.backgroundColor = .lightGray // 临时颜色，实际应加载图片
                imageView.layer.cornerRadius = 8
                imageView.layer.masksToBounds = true
                imageView.contentMode = .scaleAspectFill
                scrollView.addSubview(imageView)
                // 3. 设置约束
                imageView.snp.makeConstraints { make in
                    make.size.equalTo(imageSize)
                    make.centerY.equalToSuperview()
                    if let previous = previousImageView {
                        make.left.equalTo(previous.snp.right).offset(spacing)
                    } else {
                        make.left.equalToSuperview()
                    }
                    // 最后一个图片距离右边 5 像素
                    if index == modelArray.count - 1 {
                        make.right.equalToSuperview().offset(-5)
                    }
                    
                    let cacheKey = "base64-\(item)" as NSString
                    
                    if let cachedImage = Base64ImageCache.shared.object(forKey: cacheKey) {
                        imageView.image = cachedImage
                    } else {
                        DispatchQueue.global(qos: .userInitiated).async {
                            if let image = self.base64ToImage(base64String: item) {
                                Base64ImageCache.shared.setObject(image, forKey: cacheKey)
                                DispatchQueue.main.async {
                                    imageView.image = image
                                }
                            }
                        }
                    }
                    
                }
                
                previousImageView = imageView
            }
        }
    }
    
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
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.layer.cornerRadius = 12
        scrollView.layer.masksToBounds = true
        return scrollView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(bgView)
        contentView.addSubview(imgerView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(moneyLabel)
        contentView.addSubview(scrollView)
        bgView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.size.equalTo(CGSize(width: 365, height: 172))
            make.centerX.equalToSuperview()
        }
        
        imgerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
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
        }
        moneyLabel.snp.makeConstraints { make in
            make.centerY.equalTo(imgerView.snp.centerY)
            make.right.equalToSuperview().offset(-25)
            make.height.equalTo(30)
        }
        scrollView.snp.makeConstraints { make in
            make.right.equalTo(bgView.snp.right).offset(-5)
            make.top.equalTo(imgerView.snp.bottom).offset(12)
            make.left.equalTo(imgerView.snp.left)
            make.height.equalTo(80)
            make.bottom.equalToSuperview().offset(-15)
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension YesViewCell {
    
    func base64ToImage(base64String: String) -> UIImage? {
        // 将 Base64 字符串转换为 Data
        guard let imageData = Data(base64Encoded: base64String, options: .ignoreUnknownCharacters) else {
            print("无效的 Base64 字符串")
            return nil
        }
        
        // 将 Data 转换为 UIImage
        guard let image = UIImage(data: imageData) else {
            print("无法从数据创建图片")
            return nil
        }
        
        return image
    }
    
}

class Base64ImageCache {
    static let shared = NSCache<NSString, UIImage>()
}
