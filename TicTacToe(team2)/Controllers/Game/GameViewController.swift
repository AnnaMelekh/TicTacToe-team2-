//
//  GameViewController.swift
//  TicTacToe(team2)
//
//  Created by Igor Guryan on 30.09.2024.
//

import UIKit

class GameViewController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "background")
        
        createTopStack()
        createTurnStack(image: UIImage(named: "Oskin1")!)
        createField()
        
        
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
        
        field.topAnchor.constraint(equalTo: view.topAnchor, constant: 370).isActive = true
            field.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 45).isActive = true
            field.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -45).isActive = true
            field.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -175).isActive = true
            
        
        return field
        
    }
    
    // MARK: creating top stack of 3 views
    func createTopStack() {
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
            hStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            hStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            hStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            hStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -500),
        ])
    }
    
    // Middle Stack with Turn label & icon
    func createTurnStack(image: UIImage) {
        let hStack = UIStackView()
        hStack.widthAnchor.constraint(equalToConstant: 221).isActive = true
        hStack.heightAnchor.constraint(equalToConstant: 53).isActive = true
        hStack.axis = .horizontal
        hStack.spacing = 20
        hStack.distribution = .fill
        hStack.alignment = .center
        hStack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(hStack)
        
        let icon = UIImageView()
        icon.image = UIImage(named: "Xskin1")
        icon.widthAnchor.constraint(equalToConstant: 50).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let text = UILabel()
        text.text = "Your turn"
        text.textColor = .black
        text.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        hStack.addArrangedSubview(icon)
        hStack.addArrangedSubview(text)
        
        
        NSLayoutConstraint.activate([
            hStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 240),
            hStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 105),
            hStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -105),
            hStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -500),
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
            timer.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 20),
            timer.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -10),
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
