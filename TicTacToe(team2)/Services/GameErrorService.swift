//
//  GameErrorService.swift
//  TicTacToe(team2)
//
//  Created by Igor Guryan on 04.10.2024.
//

import Foundation

enum Keys: String {
    case leaderboard
    case settings
}

enum GameErrors: Error {
    case saveSettingsError
    case getSettingsError
}

extension GameErrors: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .saveSettingsError:
            return NSLocalizedString("Ошибка сохранения настроек игры!", comment: "Попробуйте еще раз!")
        case .getSettingsError:
            return NSLocalizedString("Ошибка чтения настроек игры!", comment: "Попробуйте еще раз!")
       
        }
    }
}
