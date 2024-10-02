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
    var startTime = 0
    var currentTurnStack: UIView!
    var currentTurnIcon: UIImage?
    var topStack: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "background")

        topStack = createTopStack()

        createTopStack()
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
        field.layer.borderColor = UIColor(named: "blue")?.cgColor
      
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
        return button

    }
    
    @objc
    private func buttonPress(_ sender: UIButton) {
        let index = sender.tag
        if ticTacModel.makeMove(index: index) {
            let imageName = ticTacModel.isOTurn ? "Xskin1" : "Oskin1"
            sender.setImage(UIImage(named: imageName), for: .normal)
            icon?.image = ticTacModel.getTurnImage()
        }
    }

    // MARK: creating top stack of 3 views
    private func createTopStack() {
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
        hStack.addArrangedSubview(createContent(item: createView(), image: UIImage(named: "Oskin1")!, title: "Player 2"))

        NSLayoutConstraint.activate([
            hStack.topAnchor.constraint(greaterThanOrEqualToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 0.5),
            hStack.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    // Middle Stack with Turn label & icon
    private func createTurnStack(image: UIImage) {
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

        let timer = UILabel()
        timer.text = "00:00"
        timer.translatesAutoresizingMaskIntoConstraints = false
        timer.textColor = .black
        timer.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        card.addSubview(timer)
        NSLayoutConstraint.activate([
            timer.topAnchor.constraint(equalTo: card.topAnchor, constant: 10),
            timer.centerXAnchor.constraint(equalTo: card.centerXAnchor),
            timer.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -10),
        ])

        // MARK: Timer is hidden or not
        timer.isHidden = false

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

}
#Preview { GameViewController() }
