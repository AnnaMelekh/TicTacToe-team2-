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
    
    private let questionBotton: UIButton = {
        $0.setImage(UIImage(named: "Rules"), for: .normal)
        return $0
    }(UIButton())
    
    private let settingButton: UIButton = {
        $0.setImage(UIImage(named: "Settings"), for: .normal)
        $0.setImage(UIImage(named: "settingPressed"), for: .highlighted)
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
    
    private let playButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(named: "blue")
        button.layer.cornerRadius = 30
        button.setTitle("Let's play", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()
    
//MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
// MARK: - Methods
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(questionBotton)
        view.addSubview(settingButton)
        view.addSubview(xoImageView)
        view.addSubview(ticTacToeLabel)
        view.addSubview(playButton)
        setupConstraints()
    }
    
    private func setupConstraints() {
        questionBotton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(21)
            make.width.equalTo(36)
            make.height.equalTo(36)
        }
        
        settingButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-21)
            make.width.equalTo(36)
            make.height.equalTo(36)
        }
        
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
            make.bottom.equalTo(view.snp.bottom).offset(-80)
            make.width.equalTo(348)
            make.height.equalTo(72)
        }
        
    }
    


}

#Preview {
    OnboardingViewController()
}
