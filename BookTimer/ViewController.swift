//
//  ViewController.swift
//  BookTimer
//
//  Created by sijan  on 1/11/22.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let time = ["15 min": 15*60, "30 min": 30*60, "60 min": 60*60]
//    let time = ["15 min": 5, "30 min": 10, "60 min": 12]
    var timer = Timer()
    var player: AVAudioPlayer?

    
    @IBOutlet weak var topLabel: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "bell-notification-tune-long", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            /* iOS 10 and earlier require the following line:
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    @IBAction func readTimeSelected(_ sender: UIButton) {
        
        topLabel.text = sender.titleLabel!.text!
        
        self.progressBar.setProgress(0, animated: true)
        
        timer.invalidate()
      
        let readTime = sender.titleLabel!.text!
        
        print(time[readTime]!)

        let originalTime = Float(time[readTime]!)
        var secondsRemaining = Float(time[readTime]!)
        
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
                if secondsRemaining > 0 {
                    print ("\(secondsRemaining) seconds")
                    secondsRemaining -= 1
                    self.progressBar.setProgress(1.0-(secondsRemaining/originalTime), animated: true)
                    
                } else {
                    self.topLabel.text = "Done :) Great Job "
                    Timer.invalidate()
                    self.progressBar.setProgress(1.0-(secondsRemaining/originalTime), animated: true)
                    self.playSound()
                    
                    
                }
            }
                
        
    }
    
 
}

