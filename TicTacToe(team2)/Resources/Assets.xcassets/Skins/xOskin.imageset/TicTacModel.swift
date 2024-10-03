//
//  TicTacModel.swift
//  TicTacToe(team2)
//
//  Created by Олег Дербин on 02.10.2024.
//

import Foundation
import UIKit

class TicTacModel {
    
    var isOTurn: Bool = false
    var gameField = [String](repeating: "", count: 9)
    
    func makeMove(index: Int) -> Bool {
        if gameField[index] != "" { return false }
        gameField[index] = isOTurn ? "X" : "O"
        isOTurn.toggle()
        return true
    }
    
    
    func getTurnImage() -> UIImage {
        return isOTurn ? UIImage(named: "Oskin1")! : UIImage(named: "Xskin1" )!
    }
}
