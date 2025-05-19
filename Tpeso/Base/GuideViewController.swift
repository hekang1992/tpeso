//
//  GuideViewController.swift
//  Tpeso
//
//  Created by 何康 on 2025/5/19.
//

import UIKit
import UIColor_Hex_Swift

class GuideViewController: UIViewController, UIScrollViewDelegate {
    
    private var startButton: UIButton!
    
    private var scrollView: UIScrollView!
    
    private let imageNames = ["guide_1", "guide_2", "guide_3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        setupStartButton()
        setupGuidePages()
    }
    
    private func setupScrollView() {
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        scrollView.bounces = false
        view.addSubview(scrollView)
    }
    
    private func setupStartButton() {
        let buttonWidth: CGFloat = SCREEN_WIDTH
        let buttonHeight: CGFloat = 100
        let buttonX = (view.bounds.width - buttonWidth) / 2
        let buttonY = view.bounds.height - 200
        startButton = UIButton(frame: CGRect(
            x: buttonX,
            y: buttonY,
            width: buttonWidth,
            height: buttonHeight
        ))
        startButton.addTarget(self, action: #selector(startApp), for: .touchUpInside)
        startButton.isHidden = true
        view.addSubview(startButton)
    }
    
    private func setupGuidePages() {
        scrollView.contentSize = CGSize(
            width: view.bounds.width * CGFloat(imageNames.count),
            height: view.bounds.height
        )
        for (index, imageName) in imageNames.enumerated() {
            let imageView = UIImageView(frame: CGRect(
                x: CGFloat(index) * view.bounds.width,
                y: 0,
                width: view.bounds.width,
                height: view.bounds.height
            ))
            imageView.image = UIImage(named: imageName)
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            scrollView.addSubview(imageView)
        }
    }
    
    @objc private func startApp() {
        UserDefaults.standard.set("1", forKey: "GUIDECLICK")
        UserDefaults.standard.synchronize()
        UIApplication.shared.windows.first?.rootViewController = IS_LOGIN ? HomeViewController() : LoginViewController()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / view.bounds.width)
        startButton.isHidden = pageIndex != CGFloat(imageNames.count - 1)
    }
}
