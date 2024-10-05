//
//  BackgroundMusicPlayer.swift
//  TicTacToe(team2)
//
//  Created by Vladimir on 05/10/24.
//

import AVFoundation

class BackgroundMusicPlayer {
    static let shared = BackgroundMusicPlayer()
    private var audioPlayer: AVAudioPlayer?
    private(set) var isMusicEnabled: Bool {
        didSet {
            UserDefaults.standard.set(isMusicEnabled, forKey: "isMusicEnabled")
            if isMusicEnabled {
                playBackgroundMusic()
            } else {
                stopBackgroundMusic()
            }
        }
    }
    
    private init() {
        self.isMusicEnabled = UserDefaults.standard.bool(forKey: "isMusicEnabled")
        setupAudioPlayer()
    }
    
    private func setupAudioPlayer() {
        guard let url = Bundle.main.url(forResource: "music1", withExtension: "mp3") else { return }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.numberOfLoops = -1
            audioPlayer?.prepareToPlay()
        } catch {
            print("Не удалось инициализировать аудиоплеер: \(error)")
        }
    }
    
    func setMusicEnabled(_ enabled: Bool) {
        isMusicEnabled = enabled
    }
    
    func playBackgroundMusic() {
        guard isMusicEnabled else { return }
        audioPlayer?.play()
    }
    
    func stopBackgroundMusic() {
        audioPlayer?.stop()
    }
}
