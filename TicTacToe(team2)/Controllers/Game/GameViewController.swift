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
        
        createView()
    }
    
    private func createView() -> UIView {
        var card = UIView()
        //        var player2Box = UIView()
        
        card.backgroundColor = UIColor(named: "gray")
        card.translatesAutoresizingMaskIntoConstraints = false
        card.layer.cornerRadius = 20
        card.widthAnchor.constraint(equalToConstant: 100).isActive = true
        card.heightAnchor.constraint(equalToConstant: 100).isActive = true
        return card
    }
    
    private func createContent(item:  UIView, image: UIImage, title: String) -> UIView {
        
        
        
        
        return item
    }
    
    func createCardImage(image: UIImage) -> UIImageView {
        let img = UIImageView() /*= UIImageView(image: UIImage(named: "XSkin1"))*/
        img.image = image
        img.translatesAutoresizingMaskIntoConstraints = false
        img.widthAnchor.constraint(equalToConstant: 50).isActive = true
        img
            .heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        return img
    }
    
    func createCardTitle(title: String) -> UILabel {
        let label = UILabel()
        label.text = title
        return label
    }
}
#Preview { GameViewController() }
