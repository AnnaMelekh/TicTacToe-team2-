//
//  ViewFactory.swift
//  TicTacToe(team2)
//
//  Created by Igor Guryan on 03.10.2024.
//

import UIKit

class ViewFactory {
    static func createShadowView() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(named: "white")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 30
        view.layer.shadowColor = UIColor(named: "lightBlue")?.cgColor
        view.layer.shadowRadius = 10.0
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.borderColor = UIColor(named: "blue")?.cgColor
        return view
    }
}
