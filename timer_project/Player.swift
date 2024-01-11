//
//  Player.swift
//  timer_project
//
//  Created by Joel Martin on 12/8/23.
//

import Foundation
import AVFoundation
import UIKit

class Player {
    var button: UIButton
    var timer: Timer?
    var count: Int
    var pressed: Bool
    var player: AVAudioPlayer?

    init(button: UIButton, count: Int) {
        self.button = button
        self.count = count
        self.pressed = false
    }
    
    @objc func updateTimer() {
        if count <= 0 {
            button.isEnabled = false
            endGame()
        } else {
            count -= 1
            updateButton()
        }
    }
    
    func startTimer() {
        if !pressed {
            pressed = true
            button.backgroundColor = .darkGray
            button.isSelected.toggle()
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: button.tag, repeats: true)
        }
    }
    
    func stopTimer() {
        if pressed {
            pressed = false
            button.isSelected.toggle()
            timer?.invalidate()
            button.backgroundColor = .none
        }
    }

    func updateButton() {
        let currentTime = Time(totalSeconds: count)
        button.setTitle(currentTime.timeString, for: .normal)
    }
    
    func playSound(button: Int) {
        let soundString: String

        switch button {
        case 0: soundString = "p1"
        case 1: soundString = "p2"
        default: soundString = "gameOver"
        }

        guard let urlString = Bundle.main.path(forResource: soundString, ofType: "mp3"),
              let player = try? AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString)) else {
            print("CANT START AUDIO")
            return
        }

        self.player = player
        player.play()
    }
    
    func endGame() {
        timer?.invalidate()
        playSound(button: button.tag)
        button.setTitleColor(.red, for: .normal)
        button.setTitle("TIMES UP!", for: .normal)
    }
}
