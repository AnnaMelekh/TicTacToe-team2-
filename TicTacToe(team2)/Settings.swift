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
    var availableSkins: [Skin]
    var isMusicEnabled: Bool
}

struct Skin: Codable {
    var oSkin: String
    var xSkin: String
    var isChecked: Bool = false
}
struct Skins {
    var skins = [
        Skin(oSkin: "Oskin1", xSkin: "Xskin1", isChecked: true),
        Skin(oSkin: "Oskin2", xSkin: "Xskin2"),
        Skin(oSkin: "Oskin3", xSkin: "Xskin3"),
        Skin(oSkin: "Oskin4", xSkin: "Xskin4"),
        Skin(oSkin: "Oskin5", xSkin: "Xskin5"),
        Skin(oSkin: "Oskin6", xSkin: "Xskin6"),
    ]
}

protocol SettingsManagerProtocol {
    
    func saveSettings(
        isGameTimeEnabled: Bool?,
        gameTime: Int?,
        skin: Skin?,
        availableSkins: [Skin]?,
        isMusicEnabled: Bool?,
        completion: @escaping(Result<Settings, Error>)->Void
    )
    
    func getSettings(completion: @escaping(Result<Settings,Error>)->Void)
}


class SettingsManager: SettingsManagerProtocol {
    
    let defaults = UserDefaults.standard
    
    func saveSettings(
        isGameTimeEnabled: Bool?,
        gameTime: Int?,
        skin: Skin?,
        availableSkins: [Skin]?,
        isMusicEnabled: Bool?,
        completion: @escaping (Result<Settings, Error>) -> Void
    ) {
        let skins = Skins()
        
        let settings = Settings(
            isGameTimeEnabled: isGameTimeEnabled ?? true,
            gameTime: gameTime ?? 30,
            skin: skin ?? Skin(oSkin: "Oskin1", xSkin: "Xskin1", isChecked: true),
            availableSkins: availableSkins ?? skins.skins ,
            isMusicEnabled: isMusicEnabled ?? false
        )
        
        let encoder = JSONEncoder()
        
        if let encoded = try? encoder.encode(settings) {
            defaults.set(encoded, forKey: Keys.settings.rawValue)
        }
        
        if let settings = defaults.object(forKey: Keys.settings.rawValue) as? Data {
            let decoder = JSONDecoder()
            if let loadedSettings = try? decoder.decode(Settings.self, from: settings) {
                completion(.success(loadedSettings))
            }
            
        } else {
            completion(.failure(GameErrors.saveSettingsError))
        }
    }
    
    func getSettings(completion: @escaping (Result<Settings, Error>) -> Void) {
        if let settings = defaults.object(forKey: Keys.settings.rawValue) as? Data {
            let decoder = JSONDecoder()
            if let loadedSettings = try? decoder.decode(Settings.self, from: settings) {
                print("Settings loaded")
                completion(.success(loadedSettings))
            }
            
        } else {
            
            if createStartSettings() {
              
                if let settings = defaults.object(forKey: Keys.settings.rawValue) as? Data {
                    let decoder = JSONDecoder()
                    if let loadedSettings = try? decoder.decode(Settings.self, from: settings) {
                            print("Settings loaded")
                            completion(.success(loadedSettings))
                        }
                }
                
            } else {
                
                completion(.failure(GameErrors.saveSettingsError))
                print("Settings didn't loaded")

            }

        }
        
        func createStartSettings() -> Bool {
            

            let skins = Skins()
            
            let settings = Settings(
                isGameTimeEnabled: true,
                gameTime: 30,
                skin: Skin(oSkin: "Oskin1", xSkin: "Xskin1", isChecked: true),
                availableSkins: skins.skins,
                isMusicEnabled: false
            )

            
            let encoder = JSONEncoder()
            
            if let encoded = try? encoder.encode(settings) {

                defaults.set(encoded, forKey: Keys.settings.rawValue)

                return true
            }
            
            return false
            
        }
        
    }
}

