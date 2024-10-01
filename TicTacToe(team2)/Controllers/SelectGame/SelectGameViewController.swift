//
//  Untitled.swift
//  TicTacToe(team2)
//
//  Created by Igor Guryan on 30.09.2024.
//

import UIKit
import SnapKit

class SelectGameViewController: UIViewController {
    
    private lazy var settingButton: UIButton = {
        $0.setImage(UIImage(named: "Settings"), for: .normal)
        $0.setImage(UIImage(named: "settingPressed"), for: .highlighted)
        $0.addTarget(self, action: #selector(goToSomeVC(_:)), for: .touchUpInside)
        return $0
    }(UIButton())
    
    private let containerStackView: UIStackView = {
        $0.backgroundColor = UIColor(named: "white")
        $0.layer.cornerRadius = 30
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.spacing = 15
        $0.alignment = .center
        return $0
    }(UIStackView())
    
    private let selectLabel: UILabel = {
        $0.text = "Select Game"
        $0.font = .systemFont(ofSize: 24, weight: .bold)
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    private let singleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Single Player", for: .normal)
        button.backgroundColor = UIColor(named: "lightBlue")
        button.layer.cornerRadius = 30
        button.setImage(UIImage(named: "SinglePlayer")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 10)
        return button
    }()
    
    private let twoPlayersButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Two Players", for: .normal)
        button.backgroundColor = UIColor(named: "lightBlue")
        button.layer.cornerRadius = 30
        button.setImage(UIImage(named: "TwoPlayers")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 10)
        return button
    }()
    
    private let spaceView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        view.backgroundColor = UIColor(named: "background")
    }
    
    private func setupUI() {
        view.addSubview(containerStackView)
        setupNavigationBar()
        containerStackView.addArrangedSubview(selectLabel)
        containerStackView.addArrangedSubview(singleButton)
        containerStackView.addArrangedSubview(twoPlayersButton)
        containerStackView.addArrangedSubview(spaceView)
        
        setupConstraints()
    }
    
    private func setupNavigationBar() {
        let settingButton = UIBarButtonItem(customView: settingButton)
        navigationItem.rightBarButtonItem = settingButton
    }
    
    private func setupConstraints() {
        containerStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(view.snp.width).multipliedBy(0.75)
            make.height.equalTo(containerStackView.snp.width).multipliedBy(0.85)
        }
        
        singleButton.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.87)
            make.height.equalToSuperview().multipliedBy(0.27)
        }
        
        twoPlayersButton.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.87)
            make.height.equalToSuperview().multipliedBy(0.27)
        }
        
        selectLabel.snp.makeConstraints { make in
//            make.height.equalTo(twoPlayersButton.snp.height).multipliedBy(1)
        }
    }
    
    @objc
    private func goToSomeVC(_ sender: UIButton) {
        if sender == settingButton {
            pushViewController(SettingsViewController())
        }
    }
    
    @objc
    func pushViewController(_ VC: UIViewController) {
        navigationController?.pushViewController(VC, animated: true)
    }
    
}


}
