//
//  Untitled.swift
//  TicTacToe(team2)
//
//  Created by Igor Guryan on 30.09.2024.
//


import UIKit
import SnapKit

class SelectGameViewController: UIViewController {
    
    //MARK: - UI elements
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
    
    private lazy var singleButton: UIButton = {
        configureButton(titleName: "Single Player", imageName: "SinglePlayer")
    }()
    
    private lazy var twoPlayersButton: UIButton = {
        configureButton(titleName: "Two Players", imageName: "TwoPlayers")
    }()
    
    private lazy var leaderboardButton: UIButton = {
        configureButton(titleName: "Leaderboard", imageName: "LeaderboardRocket")
    }()
    
    private let spaceView = UIView()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        view.backgroundColor = UIColor(named: "background")
    }
    
    //MARK: - Private methods
    private func setupUI() {
        view.addSubview(containerStackView)
        containerStackView.addArrangedSubview(selectLabel)
        containerStackView.addArrangedSubview(singleButton)
        containerStackView.addArrangedSubview(twoPlayersButton)
        containerStackView.addArrangedSubview(leaderboardButton)
        containerStackView.addArrangedSubview(spaceView)
        
        setupNavigationBar()
        setupConstraints()
    }
    
    private func setupNavigationBar() {
        let settingButton = UIBarButtonItem(customView: settingButton)
        navigationItem.rightBarButtonItem = settingButton
        navigationItem.hidesBackButton = true
    }
    
    private func configureButton(titleName: String, imageName: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(titleName, for: .normal)
        button.backgroundColor = UIColor(named: "lightBlue")
        button.layer.cornerRadius = 30
        button.setTitleColor(.black, for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 10)
        button.setImage(UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(goToSomeVC(_:)), for: .touchUpInside)
        
        return button
    }
    
    private func setupConstraints() {
        
        containerStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(view.snp.width).multipliedBy(0.75)
            make.height.equalTo(view.snp.height).multipliedBy(0.4)
        }
        
        setupButtonConstraint(button: singleButton)
        setupButtonConstraint(button: twoPlayersButton)
        setupButtonConstraint(button: leaderboardButton)
    }
    
    private func setupButtonConstraint(button: UIButton) {
        let buttonMultiplied = 0.2
        
        button.snp.makeConstraints { make in
            make.leading.equalTo(containerStackView.snp.leading).inset(20)
            make.trailing.equalTo(containerStackView.snp.trailing).inset(20)
            make.height.equalToSuperview().multipliedBy(buttonMultiplied)
        }
    }
    
    @objc
    private func goToSomeVC(_ sender: UIButton) {
        switch sender {
        case settingButton: pushViewController(SettingsViewController())
        case singleButton, twoPlayersButton:
            pushViewController(GameViewController())
        case leaderboardButton:
            pushViewController(LeaderboardViewController())
        default:
            print("Unknown button")
        }
    }
    
    @objc
    func pushViewController(_ VC: UIViewController) {
        navigationController?.pushViewController(VC, animated: true)
    }
    
}

#Preview {
    SelectGameViewController()
}
