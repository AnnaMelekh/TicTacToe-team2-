//
//  ViewController.swift
//  TicTacToe(team2)
//
//  Created by Anna Melekhina on 29.09.2024.
//

import UIKit
import SnapKit

class OnboardingViewController: UIViewController {
//    - MARK: UI Elements
    
    private lazy var questionBotton: UIButton = {
        $0.setImage(UIImage(named: "Rules"), for: .normal)
        $0.addTarget(self, action: #selector(goToSomeVC(_:)), for: .touchUpInside)
        return $0
    }(UIButton())
    
    private lazy var settingButton: UIButton = {
        $0.setImage(UIImage(named: "Settings"), for: .normal)
        $0.addTarget(self, action: #selector(goToSomeVC(_:)), for: .touchUpInside)
        return $0
    }(UIButton())
    
    private let xoImageView: UIImageView = {
        $0.image = UIImage(named: "xOskin")
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())
    
    private let ticTacToeLabel: UILabel = {
        $0.textAlignment = .center
        $0.font = .boldSystemFont(ofSize: 32)
        $0.text = "TIC-TAC-TOE"
        return $0
    }(UILabel())
    
    private lazy var playButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(named: "blue")
        button.layer.cornerRadius = 30
        button.setTitle("Let's play", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.addTarget(self, action: #selector(goToSomeVC(_:)), for: .touchUpInside)
        return button
    }()
    
//MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
       
    }
    
// MARK: - Methods
    
    private func setupUI() {
        view.backgroundColor = UIColor(named: "white")
        view.addSubview(questionBotton)
        view.addSubview(settingButton)
        view.addSubview(xoImageView)
        view.addSubview(ticTacToeLabel)
        view.addSubview(playButton)
        setupNavigationBar()
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        xoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-70)
            make.width.equalTo(245)
            make.height.equalTo(135)
        }
        
        ticTacToeLabel.snp.makeConstraints { make in
            make.top.equalTo(xoImageView.snp.bottom).inset(-31)
            make.centerX.equalToSuperview()
        }
        
        playButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-40)
            make.width.equalTo(348)
            make.height.equalTo(72)
        }
        
    }
    
    private func setupNavigationBar() {
        let rightButton = UIBarButtonItem(customView: settingButton)
        let leftButton = UIBarButtonItem(customView: questionBotton)
        navigationItem.rightBarButtonItem = rightButton
        navigationItem.leftBarButtonItem = leftButton
    }
    
    @objc
    private func goToSomeVC(_ sender: UIButton) {
        if sender == questionBotton {
            pushViewController(HowToPlayViewController())
        } else if sender == settingButton {
            pushViewController(SettingsViewController())
        } else if sender == playButton {
            pushViewController(SelectGameViewController())
        }
    }
    
    @objc
    func pushViewController(_ VC: UIViewController) {
        navigationController?.pushViewController(VC, animated: true)
    }

}

#Preview {
    OnboardingViewController()
}

