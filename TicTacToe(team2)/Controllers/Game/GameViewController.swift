//
//  GameViewController.swift
//  TicTacToe(team2)
//
//  Created by Igor Guryan on 30.09.2024.
//

import UIKit
import SnapKit

class GameViewController: UIViewController {
    
    var field: UIView!
    var ticTacModel = TicTacModel()
    var icon: UIImageView?
    var currentTurnStack: UIView!
    var currentTurnIcon: UIImage?
    var topStack: UIView!
    var buttonsCoordinate: [Int : CGPoint] = [:]
    var timerLabel: UILabel!
    var buttonss: [UIButton] = []
    var gameTimer: Timer?
    var gameTime = 0
    var isGameTimerOn = false
    var isGameFinished = false
    var xImage: String = ""
    var oImage: String = ""
    var turnTextLabel: UILabel?
    var isTimerOn: Bool?
    
    var settingsManager = SettingsManager()
    var settings: Settings?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getSettings()
        view.backgroundColor = UIColor(named: "background")
        topStack = createTopStack()
        currentTurnStack = createTurnStack(image: getImageIcons().x)
        field = createField()
        field.addSubview(createVStackButtons())
        setTimer()
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
        buttonss.append(button)
        
        return button
        
    }
    
    @objc
    private func buttonPress(_ sender: UIButton) {
        if !isGameTimerOn { startGameTimer() }
        updateTimerLabel()
        if isTimerOn! {
            ticTacModel.startTimer()
        }
        let index = sender.tag
        buttonsCoordinate[index] = sender.convert(sender.bounds.origin, to: view)
        if ticTacModel.makeMove(index: index) {
            let imageIcon = ticTacModel.isOTurn ? getImageIcons().x : getImageIcons().o
            sender.setImage(imageIcon, for: .normal)
            icon?.image = ticTacModel.isOTurn ? getImageIcons().o : getImageIcons().x
            turnTextLabel?.text = ticTacModel.isOTurn ? "Player Two Turn" : "You turn"
            sender.isUserInteractionEnabled = false
            if let winCombo = ticTacModel.checkWin(completion: { [weak self] winner in

                if self?.isGameFinished == false {
                    self?.isGameFinished = true
                    self?.convertTime()
                    self?.turnOffButtons()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
                        let resultVC = ResultViewController(result: .win, gameMode: .multiplayer)
                    self?.navigationController?.pushViewController(resultVC, animated: true)
                    self?.ticTacModel.stopTimer()
                    resultVC.winner = winner
                    }
                }
            }) {
                drawWinningLine(for: winCombo)
            }
             else if buttonsCoordinate.count == 9 {
                 turnOffButtons()
                 let resultVC = ResultViewController(result: .draw, gameMode: .multiplayer)
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

        hStack.addArrangedSubview(createContent(item: createView(), image: getImageIcons().x, title: "You"))
        
        hStack.addArrangedSubview(createTimerView())
        hStack.addArrangedSubview(createContent(item: createView(), image: getImageIcons().o, title: "Player 2"))
        
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
        
        turnTextLabel = UILabel()
        turnTextLabel?.text = "Your turn"
        turnTextLabel?.textColor = .black
        turnTextLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        hStack.addArrangedSubview(icon!)
        hStack.addArrangedSubview(turnTextLabel!)
        
        
        
        NSLayoutConstraint.activate([
            hStack.topAnchor.constraint(equalTo: topStack.bottomAnchor, constant: 50),
            hStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            hStack.widthAnchor.constraint(equalToConstant: 300)
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
                let resultVC = ResultViewController(result: .lose, gameMode: .multiplayer)
                self?.navigationController?.pushViewController(resultVC, animated: true)
            }
        }
    }
    
    private func turnOffButtons() {
        gameTimer?.invalidate()
        gameTime = 0
        for button in buttonss {
            button.isUserInteractionEnabled = false
        }
    }
    
    private func convertTime() {
        let time = gameTime
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
    
    private func getImageIcons() -> (x: UIImage, o: UIImage) {
        let xImageName = (settings?.skin.xSkin)!
        let oImageName = (settings?.skin.oSkin)!
        return (UIImage(named: xImageName)!, UIImage(named: oImageName)!)
    }
    
    private func setTimer() {
        isTimerOn = settings?.isGameTimeEnabled
        if !isTimerOn! {
            timerLabel.isHidden = true
        }
    }
    
    
}

#Preview { GameViewController() }
