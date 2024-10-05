//
//  SinglePlayerViewController.swift
//  TicTacToe(team2)
//
//  Created by Даниил Павленко on 05.10.2024.
//

import SnapKit
import UIKit

class SinglePlayerViewController: UIViewController {
    
    var field: UIView!
    var ticTacModel = TicTacModel()
    var icon: UIImageView?
    var currentTurnStack: UIView!
    var currentTurnIcon: UIImage?
    var topStack: UIView!
    var buttonsCoordinate: [Int : CGPoint] = [:]
    var timerLabel: UILabel!
    var buttonsArray: [UIButton] = []
    var gameTimer: Timer?
    var gameTime = 0
    var gameMode: GameMode = .medium
    var isGameTimerOn = false
    
    var stopGame = false
    var skin = SettingsViewController().skins
    var skinO = ""
    var skinX = ""
    
    var settingsManager = SettingsManager()
    var settings: Settings?
    
    enum GameMode {
        case easy, medium, hard
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getSettings()
        view.backgroundColor = UIColor(named: "background")
        navigationItem.hidesBackButton = true
        topStack = createTopStack()
        
        currentTurnStack = createTurnStack(image: ticTacModel.getTurnImage())
        
        field = createField()
        field.addSubview(createVStackButtons())
        
    }
    
    
    // MARK: creating game field view
    
    func createVStackButtons() -> UIStackView {
        let vStack = UIStackView()
        
        vStack.widthAnchor.constraint(equalToConstant: 290).isActive = true
        vStack.heightAnchor.constraint(equalToConstant: 290).isActive = true
        vStack.axis = .vertical
        vStack.spacing = 20
        vStack.distribution = .fillEqually
        vStack.alignment = .center
        vStack.translatesAutoresizingMaskIntoConstraints = false
        
        vStack.addArrangedSubview(createStackOfButtons(row: 1))
        vStack.addArrangedSubview(createStackOfButtons(row: 2))
        vStack.addArrangedSubview(createStackOfButtons(row: 3))
        
        
        field.addSubview(vStack)
        
        NSLayoutConstraint.activate([
            
            vStack.topAnchor.constraint(lessThanOrEqualToSystemSpacingBelow: field.topAnchor, multiplier: 0.5),
            vStack.centerXAnchor.constraint(equalToSystemSpacingAfter: field.centerXAnchor, multiplier: 0.5),
            vStack.bottomAnchor.constraint(lessThanOrEqualToSystemSpacingBelow: field.bottomAnchor, multiplier: 0.5),
        ])
        
        return vStack
    }
    
    func createField() -> UIView {
        let field = UIView()
        
        field.backgroundColor = UIColor(named: "white")
        field.translatesAutoresizingMaskIntoConstraints = false
        field.layer.cornerRadius = 30
        field.layer.shadowColor = UIColor(named: "lightBlue")?.cgColor
        field.layer.shadowRadius = 10.0
        field.layer.shadowOpacity = 1
        field.layer.shadowOffset = CGSize(width: 0, height: 0)
        field.widthAnchor.constraint(equalToConstant: 300).isActive = true
        field.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        view.addSubview(field)
        
        field.topAnchor.constraint(lessThanOrEqualTo: currentTurnStack.bottomAnchor, constant: 50).isActive = true
        field.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        return field
        
    }
    
    // MARK: creating Hstack of 3 buttons
    
    private func createStackOfButtons(row: Int) -> UIStackView {
        let hStack = UIStackView()
        hStack.widthAnchor.constraint(equalToConstant: 280).isActive = true
        hStack.heightAnchor.constraint(equalToConstant: 103).isActive = true
        hStack.axis = .horizontal
        hStack.spacing = 20
        hStack.distribution = .equalSpacing
        hStack.alignment = .center
        hStack.translatesAutoresizingMaskIntoConstraints = false
        
        if row == 1 {
            for i in 0..<3 {
                hStack.addArrangedSubview(createButton(index: i))
            }
        } else if row == 2 {
            for i in 3..<6 {
                hStack.addArrangedSubview(createButton(index: i))
            }
        } else if row == 3 {
            for i in 6..<9 {
                hStack.addArrangedSubview(createButton(index: i))
            }
        }
        return hStack
    }
    
    private func createButton(index: Int) -> UIButton {
        let button = UIButton()
        
        button.backgroundColor = UIColor(named: "lightBlue")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 20
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        button.heightAnchor.constraint(equalToConstant: 80).isActive = true
        button.tag = index
        button.addTarget(self, action: #selector(buttonPress(_:)), for: .touchUpInside)
        view.addSubview(button)
        buttonsArray.append(button)
        
        return button
        
    }
    
    @objc
    private func buttonPress(_ sender: UIButton) {
        for i in skin {
            if i.isChecked == true {
                skinO = i.oSkin
                skinX = i.xSkin
                print(123)
            }
        }
        
        if !isGameTimerOn { startGameTimer() }
        updateTimerLabel()
        
        let index = sender.tag
        buttonsCoordinate[index] = sender.convert(sender.bounds.origin, to: view)
        if ticTacModel.makeMove(index: index) {
            ticTacModel.startTimer()
            let imageName = ticTacModel.isOTurn ? skinX : skinO
            sender.setImage(UIImage(named: imageName), for: .normal)
            icon?.image = ticTacModel.getTurnImage()
            if let winCombo = ticTacModel.checkWin(completion: { [weak self] winner in
                self?.turnOffButtons()
                self!.stopGame = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
                    let resultVC = ResultViewController(result: .win, gameMode: .singleplayer)
                    self?.navigationController?.pushViewController(resultVC, animated: true)
                    self?.ticTacModel.stopTimer()
                    resultVC.winner = winner
                }
            }) {
                drawWinningLine(for: winCombo)
            }
             else if buttonsCoordinate.count == 9 {
                 turnOffButtons()
                 let VC = ResultViewController(result: .draw, gameMode: .singleplayer)
                self.navigationController?.pushViewController(VC, animated: true)
                ticTacModel.stopTimer()
            }
        } else {
            return
        }
        
        for button in buttonsArray {
            button.isEnabled = false
        }
        
        if buttonsCoordinate.count != 9 && stopGame == false {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
                for button in self.buttonsArray {
                    button.isEnabled = true
                }
                self.computerMove()
            }
        }
        
    }
    
    private func computerMove() {
        
        var computerTurn = Int.random(in: 0..<9)
        var currentButton = UIButton()
        let winCombination = ticTacModel.winCombination
        let gameField = ticTacModel.gameField
        
        func easyMove() {
            while ticTacModel.gameField[computerTurn] != "" {
                computerTurn = Int.random(in: 0..<9)
            }
        }
        
        func mediumMove() {
            print(32122323)
            for combination in winCombination {
                if gameField[combination[0]] == "O" && gameField[combination[1]] == "O" && gameField[combination[2]] == "" {
                    computerTurn = combination[2]

                } else if gameField[combination[0]] == "O" && gameField[combination[2]] == "O" && gameField[combination[1]] == "" {
                    computerTurn = combination[1]
                    
                    

                } else if gameField[combination[1]] == "O" && gameField[combination[2]] == "O" && gameField[combination[0]] == ""  {
                    computerTurn = combination[0]
                }
                else {
                    easyMove()
                }
            }
        }
        
        func hardMove() {
            for combination in winCombination {
                if gameField[combination[0]] == "X" && gameField[combination[1]] == "X" && gameField[combination[2]] == "" {
                    computerTurn = combination[2]
                    
                    
                } else if gameField[combination[0]] == "X" && gameField[combination[2]] == "X" && gameField[combination[1]] == "" {
                    computerTurn = combination[1]
                    
                    
                } else if gameField[combination[1]] == "X" && gameField[combination[2]] == "X" && gameField[combination[0]] == "" {
                    computerTurn = combination[0]
                    
                } else {
                    mediumMove()
                }
            }
        }
        
        //уровни сложности
        switch gameMode {
        case .easy:
            easyMove()
        case .medium:
            mediumMove()
        case .hard:
            hardMove()
        }
        
        for button in buttonsArray {
            if button.tag == computerTurn {
                currentButton = button
            }
        }
        
        let index = currentButton.tag
        if !isGameTimerOn { startGameTimer() }
        updateTimerLabel()
        ticTacModel.startTimer()
        buttonsCoordinate[index] = currentButton.convert(currentButton.bounds.origin, to: view)
        if ticTacModel.makeMove(index: index) {
            let imageName = ticTacModel.isOTurn ? skinX : skinO
            currentButton.setImage(UIImage(named: imageName), for: .normal)
            icon?.image = ticTacModel.getTurnImage()
            if let winCombo = ticTacModel.checkWin(completion: { [weak self] winner in
                self?.turnOffButtons()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
                    let resultVC = ResultViewController(result: .lose, gameMode: .singleplayer)
                    self?.navigationController?.pushViewController(resultVC, animated: true)
                    self?.ticTacModel.stopTimer()
                    resultVC.winner = winner
                }
            }) {
                drawWinningLine(for: winCombo)
            }
             else if buttonsCoordinate.count == 9 {
                 turnOffButtons()
                 let resultVC = ResultViewController(result: .draw, gameMode: .singleplayer)
                 self.navigationController?.pushViewController(resultVC, animated: true)
                ticTacModel.stopTimer()
            }
        }
    }
    
    // MARK: creating top stack of 3 views
    private func createTopStack() -> UIStackView {
        let hStack = UIStackView()
        hStack.widthAnchor.constraint(equalToConstant: 330).isActive = true
        hStack.heightAnchor.constraint(equalToConstant: 103).isActive = true
        hStack.axis = .horizontal
        hStack.spacing = 20
        hStack.distribution = .equalSpacing
        hStack.alignment = .center
        hStack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(hStack)
        
        hStack.addArrangedSubview(createContent(item: createView(), image: UIImage(named: "Xskin1")!, title: "You"))
        
        hStack.addArrangedSubview(createTimerView())
        hStack.addArrangedSubview(createContent(item: createView(), image: UIImage(named: "Oskin1")!, title: "Bot Ai"))
        
        NSLayoutConstraint.activate([
            hStack.topAnchor.constraint(greaterThanOrEqualToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 0.5),
            hStack.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        return hStack
    }
    
    // Middle Stack with Turn label & icon
    private func createTurnStack(image: UIImage) -> UIStackView {
        let hStack = UIStackView()
        hStack.widthAnchor.constraint(equalToConstant: 221).isActive = true
        hStack.heightAnchor.constraint(equalToConstant: 53).isActive = true
        hStack.axis = .horizontal
        hStack.spacing = 20
        hStack.distribution = .fill
        hStack.alignment = .center
        hStack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(hStack)
        icon = UIImageView()
        icon?.image = image
        icon?.widthAnchor.constraint(equalToConstant: 50).isActive = true
        icon?.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let text = UILabel()
        text.text = "Your turn"
        text.textColor = .black
        text.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        hStack.addArrangedSubview(icon!)
        hStack.addArrangedSubview(text)
        
        
        
        NSLayoutConstraint.activate([
            hStack.topAnchor.constraint(equalTo: topStack.bottomAnchor, constant: 50),
            hStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            hStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -105)
        ])
        return hStack
    }
    
    private func createView() -> UIView {
        let card = UIView()
        
        card.backgroundColor = UIColor(named: "lightBlue")
        card.translatesAutoresizingMaskIntoConstraints = false
        card.layer.cornerRadius = 30
        card.widthAnchor.constraint(equalToConstant: 101).isActive = true
        card.heightAnchor.constraint(equalToConstant: 101).isActive = true
        return card
    }
    
    // MARK: middle View is transparent
    private func createTimerView() -> UIView {
        let card = UIView()
        
        card.backgroundColor = UIColor(named:"background")
        card.translatesAutoresizingMaskIntoConstraints = false
        card.layer.cornerRadius = 30
        card.widthAnchor.constraint(equalToConstant: 150).isActive = true
        card.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        timerLabel = UILabel()
        timerLabel.text = "00:00"
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        timerLabel.textColor = .black
        timerLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        card.addSubview(timerLabel)
        NSLayoutConstraint.activate([
            timerLabel.topAnchor.constraint(equalTo: card.topAnchor, constant: 10),
            timerLabel.centerXAnchor.constraint(equalTo: card.centerXAnchor),
            timerLabel.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -10),
        ])
        
        // MARK: timerLabel is hidden or not
        timerLabel.isHidden = false
        
        return card
    }
    
    // MARK: fills View with an icon & players labels
    private func createContent(item:  UIView, image: UIImage, title: String) -> UIView {
        
        let image = createCardImage(image: image)
        let title = createCardTitle(title: title)
        
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 2
        stack.distribution = .fill
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(image)
        stack.addArrangedSubview(title)
        
        
        item.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: item.topAnchor, constant: 13),
            stack.leadingAnchor.constraint(equalTo: item.leadingAnchor, constant: 13),
            stack.trailingAnchor.constraint(equalTo: item.trailingAnchor, constant: -13),
            stack.bottomAnchor.constraint(equalTo: item.bottomAnchor, constant: -13),
        ])
        
        return item
    }
    
    // Adds icon
    func createCardImage(image: UIImage) -> UIImageView {
        let img = UIImageView()
        img.image = image
        img.translatesAutoresizingMaskIntoConstraints = false
        img.widthAnchor.constraint(equalToConstant: 50).isActive = true
        img.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        return img
    }
    
    // Adds player's text label
    func createCardTitle(title: String) -> UILabel {
        let label = UILabel()
        label.text = title
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }
    
    func drawWinningLine(for combination: [Int]) {
        guard let startButton = buttonsCoordinate[combination[0]],
              let endButton = buttonsCoordinate[combination[2]] else { return }
        
        let weight: CGFloat = 40
        let startX = startButton.x + weight
        let startY = startButton.y + weight
        
        let endX = endButton.x + weight
        let endY = endButton.y + weight
        
        
        let linePath = UIBezierPath()
        linePath.move(to: CGPoint(x: startX, y: startY))
        linePath.addLine(to: CGPoint(x: endX, y: endY))
        
        let lineLayer = CAShapeLayer()
        lineLayer.path = linePath.cgPath
        lineLayer.strokeColor = UIColor(named: "blue")?.cgColor
        lineLayer.lineWidth = 10
        lineLayer.lineCap = .round
        lineLayer.strokeEnd = 0
        view.layer.addSublayer(lineLayer)
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 1
        lineLayer.add(animation, forKey: "line")
        lineLayer.strokeEnd = 1
    }
    
    private func updateTimerLabel() {
        
        ticTacModel.timerUpdate = { [weak self] time in
            let minutes = time / 60
            let seconds = time % 60
            self?.timerLabel.text = String(format: "%02d:%02d", minutes, seconds)
            if time == 0 {
                let resultVC = ResultViewController(result: .lose, gameMode: .singleplayer)
                self?.navigationController?.pushViewController(resultVC, animated: true)
            }
        }
    }
    
    private func turnOffButtons() {
        convertTime(time: gameTime)
        gameTimer?.invalidate()
        gameTime = 0
        for button in buttonsArray {
            button.isUserInteractionEnabled = false
        }
    }
    
    private func convertTime(time: Int) {
        let minutes = time / 60
        let seconds = time % 60
        let convertTime = String(format: "%02d:%02d", minutes, seconds)
        ticTacModel.bestTimes.append(convertTime)
        UserDefaults.standard.set(ticTacModel.bestTimes, forKey: "bestTimes")
    }
    
    private func startGameTimer() {
        isGameTimerOn.toggle()
        gameTimer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(updateGameTimer),
            userInfo: nil,
            repeats: true
        )
    }
    
    @objc
    private func updateGameTimer() {
        gameTime += 1
    }
    
    
    
    func getSettings() {
        settingsManager.getSettings(completion: { result in
            switch result {
            case .success(let settings):
                self.settings = settings
                print("Data was loaded")
            case .failure(let error):
                print(error.localizedDescription)
                print("Didnt loaddata")
            }
        })
    }
    
}

#Preview { GameViewController() }
