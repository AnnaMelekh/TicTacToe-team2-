//
//  DifficulSettingController.swift
//  TicTacToe(team2)
//
//  Created by Олег Дербин on 06.10.2024.
//

import UIKit

class DifficulSettingController: UIViewController {
    
    private lazy var settingButton: UIButton = {
        $0.setImage(UIImage(named: "Settings"), for: .normal)
        $0.setImage(UIImage(named: "settingPressed"), for: .highlighted)
        $0.addTarget(self, action: #selector(goToSomeVC(_:)), for: .touchUpInside)
        return $0
    }(UIButton())
    
    private lazy var backButton: UIButton = {
        $0.setImage(UIImage(named: "BackIcon"), for: .normal)
        $0.setImage(UIImage(named: "settingPressed"), for: .highlighted)
        $0.addTarget(self, action: #selector(goToSomeVC(_:)), for: .touchUpInside)
        return $0
    }(UIButton())
    
    private let containerStackView: UIStackView = {
        $0.backgroundColor = UIColor(named: "white")
        $0.layer.cornerRadius = 30
        $0.axis = .vertical
        $0.distribution = .fillProportionally
        $0.spacing = 10
        $0.alignment = .center
        
        $0.layer.shadowColor = UIColor(named: "lightBlue")?.cgColor
        $0.layer.shadowRadius = 10.0
        $0.layer.shadowOpacity = 1
        $0.layer.shadowOffset = CGSize(width: 0, height: 0)
        
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
    
    private lazy var difficulBoardButton: UIButton = {
        configureButton(titleName: "Difficulty level", imageName: "SinglePlayer")
    }()
    
    private let spaceView = UIView()
    private let spaceViewTwo = UIView()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        view.backgroundColor = UIColor(named: "background")
    }
    
    //MARK: - Private methods
    private func setupUI() {
        view.addSubview(containerStackView)
        containerStackView.addArrangedSubview(spaceViewTwo)
        containerStackView.addArrangedSubview(selectLabel)
        containerStackView.addArrangedSubview(singleButton)
        containerStackView.addArrangedSubview(twoPlayersButton)
        containerStackView.addArrangedSubview(difficulBoardButton)
        containerStackView.addArrangedSubview(leaderboardButton)
        containerStackView.addArrangedSubview(spaceView)
//
        setupNavigationBar()
        setupConstraints()
    }
    
    private func setupNavigationBar() {
        let settingButton = UIBarButtonItem(customView: settingButton)
        let backButton = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = settingButton
        navigationItem.hidesBackButton = true
    }
    
    private func configureButton(titleName: String, imageName: String) -> UIButton {
        let button = UIButton(type: .system)
        var config = UIButton.Configuration.borderless()
        config.title = titleName
        config.image = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal)
        config.imagePadding = 10
        config.attributedTitle = AttributedString(
        titleName,
        attributes: AttributeContainer([.font: UIFont.systemFont(ofSize: 20, weight: .semibold),
                                        .foregroundColor: UIColor.black])
        )
        button.configuration = config
        button.backgroundColor = UIColor(named: "lightBlue")
        button.layer.cornerRadius = 30
        button.addTarget(self, action: #selector(goToSomeVC(_:)), for: .touchUpInside)
        
        return button
    }
    
    private func setupConstraints() {
        
        containerStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(view.snp.width).multipliedBy(0.75)
            make.height.equalTo(view.snp.height).multipliedBy(0.5)
        }
        
        selectLabel.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        setupButtonConstraint(button: singleButton)
        setupButtonConstraint(button: twoPlayersButton)
        setupButtonConstraint(button: difficulBoardButton)
        setupButtonConstraint(button: leaderboardButton)
    }
    
    private func setupButtonConstraint(button: UIButton) {
        let buttonMultiplied = 0.18
        
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
        case singleButton:
            pushViewController(SinglePlayerViewController())
        case twoPlayersButton:
            pushViewController(GameViewController())
        case leaderboardButton:
            pushViewController(LeaderboardViewController())
        case difficulBoardButton:
            let VC = DifficulSettingController()
            let navigationController = UINavigationController(rootViewController: VC)
            navigationController.modalPresentationStyle = .fullScreen
            present(navigationController, animated: true)
        case backButton:
            pushViewController(SelectGameViewController())
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
    DifficulSettingController()
}
