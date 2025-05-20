//
//  HomeViewController.swift
//  Tpeso
//
//  Created by 何康 on 2025/5/19.
//

import UIKit
import TYAlertController

class HomeViewController: BaseViewController {
    
    lazy var homeView: HomeView = {
        let homeView = HomeView()
        return homeView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(homeView)
        homeView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        homeView.applyBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            let compleView = ApplyView(frame: CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT))
            let alertVc = TYAlertController(alert: compleView, preferredStyle: .actionSheet)!
            self.present(alertVc, animated: true)
            
            compleView.completBtn.rx.tap.subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.dismiss(animated: true) {
                    
                }
            }).disposed(by: disposeBag)
            
        }).disposed(by: disposeBag)
        
        homeView.settingBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            let stVc = SettingViewController()
            self.navigationController?.pushViewController(stVc, animated: true)
        }).disposed(by: disposeBag)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
