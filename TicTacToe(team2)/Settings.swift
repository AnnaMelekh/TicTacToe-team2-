//
//  Settings.swift
//  TicTacToe(team2)
//
//  Created by Igor Guryan on 02.10.2024.
//

import Foundation

struct Settings: Codable {
    var isGameTimeEnabled: Bool
    var gameTime: Int
    var skin: Skin
}

struct Skin: Codable {
    var oSkin: String
    var xSkin: String
    var isChecked: Bool = false
}


