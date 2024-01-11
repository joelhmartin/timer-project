//
//  ViewController.swift
//  timer_project
//
//  Created by Joel Martin on 10/6/23.
//

import UIKit
import AVFoundation

class PlayGameView: UIViewController {
    
    var player: AVAudioPlayer?
    
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!

    var hours = 0
    var minutes = 0
    var seconds = 0
    var totalSeconds = 30
    var players: [Player] = []
    var player1: Player!
    var player2: Player!
    
    @IBAction func buttonPressed(_ sender: UIButton) {

        player1.updateButton()
        player2.updateButton()

        for player in players {
            if player.button.tag != sender.tag {
                player.stopTimer()
            } else {
                player.startTimer()
            }
        }
    }
    
    @IBAction func pausePressed(_ sender: UIButton) {
        stop()
    }
    
    @IBAction func resetPressed(_ sender: Any) {
        stop()
        start()
    }
    
    func stop() {
        for player in players {
            player.timer?.invalidate()
            player.pressed = false
            player.button.backgroundColor = .none
        }
    }
    
    func start() {
        for player in players {
            player.count = totalSeconds
            
            player.timer?.invalidate()
            player.button.isEnabled = true
            player.button.setTitleColor(.black, for: .normal)
            player.button.backgroundColor = .none
            player.updateButton()
        }

    }
    
    func playSong() {
        
        guard let url = Bundle.main.url(forResource: "gameLoop", withExtension: "mp3"),
              let player = try? AVAudioPlayer(contentsOf: url) else {
            print("CANT START AUDIO")
            return
        }

        self.player = player
        player.play()
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        playSong()
        
        totalSeconds = hours * 3600 + minutes * 60 + seconds

        button2.transform = CGAffineTransformMakeRotation(Double.pi)

        player1 = Player(button: button1, count: totalSeconds)
        player2 = Player(button: button2, count: totalSeconds)
        
        players.append(player1)
        players.append(player2)
        
        for (index, player) in players.enumerated() {
            player.button.tag = index
        }

        start()
    }
}
