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
    let winCombination = [
        [0, 1, 2], [3, 4, 5], [6, 7, 8],
        [0, 3, 6], [1, 4, 7], [2, 5, 8],
        [0, 4, 8], [2, 4, 6]
    ]
    
    func makeMove(index: Int) -> Bool {
        if gameField[index] != "" { return false }
        gameField[index] = isOTurn ? "X" : "O"
        isOTurn.toggle()
        return true
    }
    
    func getTurnImage() -> UIImage {
        return isOTurn ? UIImage(named: "Oskin1")! : UIImage(named: "Xskin1" )!
    }
    
    
    func checkWin(completion: () -> ()) -> [Int]? {
        var winCombo: [Int]?
        winCombination.forEach { combination in
            let one = gameField[combination[0]]
            let two = gameField[combination[1]]
            let three = gameField[combination[2]]
            if one != "" && one == two && two == three {
                winCombo = combination
                completion()
            }
        }
        return winCombo
    }
    
    
//    func paintWinLine(combination: [Int]) {
//        let start = 0
//        let finish = 2
//        
//        
//        let linePath = UIBezierPath()
//        linePath.move(to: <#T##CGPoint#>)
//    }
}
