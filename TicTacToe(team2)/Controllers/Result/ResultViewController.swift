
//  ResultViewController.swift
//  TicTacToe(team2)
//
//  Created by Igor Guryan on 30.09.2024.
//

import UIKit
import SnapKit

enum GameMode {
    case multiplayer
    case singleplayer
}

enum GameResult {
    case win
    case lose
    case draw
}


class ResultViewController: UIViewController {
    
    var playAgainButton: UIButton!
    var backButton: UIButton!
    var result: GameResult
    var winner: String = ""
    var gameMode: GameMode
    
    init(result: GameResult, gameMode: GameMode) {
        self.gameMode = gameMode
        self.result = result
        super.init(nibName: nil, bundle: nil)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "background")
        navigationItem.hidesBackButton = true
        
        
        
        
        let resultData = getResultData(for: result)
        
        //  create  label & image)
        let imageView = UIImageView(image: resultData.image)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemYellow
        
        let label = UILabel()
        label.text = resultData.text
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(named: "blue")
        backgroundView.layer.cornerRadius = 150
        backgroundView.addSubview(imageView)
        
        // create ResultstackView (label + image)
        let resultStackView = UIStackView(arrangedSubviews: [label, backgroundView])
        resultStackView.axis = .vertical
        resultStackView.spacing = 20
        resultStackView.alignment = .center
        view.addSubview(resultStackView)
        
        
        playAgainButton = UIButton(type: .system)
        playAgainButton.setTitle("Play again", for: .normal)
        playAgainButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        playAgainButton.setTitleColor(.white, for: .normal)
        playAgainButton.backgroundColor = UIColor(named: "blue")
        playAgainButton.layer.cornerRadius = 30
        playAgainButton.addTarget(self, action: #selector(goToSomeVCTest), for: .touchUpInside)
        
        
        backButton = UIButton(type: .system)
        backButton.setTitle("Back", for: .normal)
        backButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        backButton.setTitleColor(UIColor(named: "blue"), for: .normal)
        backButton.backgroundColor = .clear
        backButton.layer.cornerRadius = 30
        backButton.layer.borderWidth = 1
        backButton.layer.borderColor = UIColor(named: "blue")?.cgColor
        backButton.addTarget(self, action: #selector(goToSomeVCTest), for: .touchUpInside)
        
        // create ButtonStackView
        let buttonStackView = UIStackView(arrangedSubviews: [playAgainButton, backButton])
        buttonStackView.axis = .vertical
        buttonStackView.spacing = 10
        buttonStackView.alignment = .fill
        view.addSubview(buttonStackView)
        
        
        
        resultStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-50)
        }
        
        
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(220)
            make.edges.equalToSuperview().inset(50)
        }
        
        backgroundView.snp.makeConstraints { make in
            make.width.height.equalTo(300)
        }
        
        
        buttonStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-20)
        }
        
        
        playAgainButton.snp.makeConstraints { make in
            make.height.equalTo(72)
        }
        
        backButton.snp.makeConstraints { make in
            make.height.equalTo(72)
        }
    }
    
    // Switch Result
    private func getResultData(for result: GameResult) -> (image: UIImage?, text: String) {
        switch result {
        case .win:
            return (UIImage(named: "Win"), "Player \(winner) win!")
        case .lose:
            return (UIImage(named: "Loose"), "You Lose!")
        case .draw:
            return (UIImage(named: "Draw"), "Draw!")
        }
    }
    
    
    
    @objc
    private func goToSomeVCTest(_ sender: UIButton) {
        if sender == playAgainButton {
            let gameVC = GameViewController()
//            let navigationController = self.navigationController
//            navigationController?.setViewControllers([SelectGameViewController(), gameVC], animated: true)
//            
            if gameMode == .multiplayer {
                let gameVC = GameViewController()  // Игра с другом
                navigationController?.setViewControllers([SelectGameViewController(), gameVC], animated: true)
            } else if gameMode == .singleplayer {
                let singlePlayerVC = SinglePlayerViewController(gameMode: .easy)  // Игра с ботом
                navigationController?.setViewControllers([SelectGameViewController(), singlePlayerVC], animated: true)
            }
            
        } else if sender == backButton {
            pushViewController(SelectGameViewController())
        }
    }
    
    
    @objc
    func pushViewController(_ VC: UIViewController) {
        navigationController?.pushViewController(VC, animated: true)
    }
}





//#Preview { ResultViewController(result: .win) }
