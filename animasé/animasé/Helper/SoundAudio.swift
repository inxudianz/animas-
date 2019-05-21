//
//  SoundAudio.swift
//  animasé
//
//  Created by William Inx on 20/05/19.
//  Copyright © 2019 William Inx. All rights reserved.
//

import Foundation
import AVFoundation

class SoundAudio {
    
    var audioPlayer :AVAudioPlayer?
    var audioURL :URL?
    
    func addSoundFX(audio: String, isRepeat: Bool) {
        
        do {
            audioURL = Bundle.main.url(forResource: audio, withExtension: "wav")
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            audioPlayer = try AVAudioPlayer(contentsOf: audioURL!, fileTypeHint: AVFileType.mp3.rawValue)
            
            guard let player = audioPlayer else { return }
            if isRepeat == true {
                player.numberOfLoops = -1
            }
            
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
