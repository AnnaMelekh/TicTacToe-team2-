//
//  Untitled.swift
//  TicTacToe(team2)
//
//  Created by Igor Guryan on 30.09.2024.
//

import UIKit

class SelectGameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemMint
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
        navigationItem.hidesBackButton = true
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
