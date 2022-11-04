//
//  SoundManager.swift
//  CS50 Final
//
//  Created by Triana Cerda on 11/3/22.
//

import Foundation
import AVFoundation

class SoundManager {
    
    static var audioPlayer:AVAudioPlayer?
    
    enum SoundEffect  {
        
        case flip
        case shuffle
        case match
        case nomatch
        case win
        case lost
    }
    
    static func playSound(_ effect:SoundEffect) {
        
        // holds the sound file
        var soundFilename = ""
        
        // similar to a reducer that has different soundcase files
        // will determine which sound gets played when coorelating sound is passed in
        switch effect {
            
        case .flip:
            soundFilename = "flip"
            
        case .shuffle:
            soundFilename = "shuffle"
            
        case .match:
            soundFilename = "match"
            
        case .nomatch:
            soundFilename = "nomatch"
            
        case .win:
            soundFilename = "win"
            
        case .lost:
            soundFilename = "lost"
            
        }
        
        // can be nil-- getst the path to the correct file in the bundle
        let bundlePath = Bundle.main.path(forResource: soundFilename, ofType: "mp3")
        
        // this won't let the app crash if soundfile isn't found
        guard bundlePath != nil else {
            print("Sound file not found")
            return
        }
        
        // create a URL obj from this string path
        let soundURL = URL(fileURLWithPath: bundlePath!)
        
        // this statement throws an error if it can't create an audio player obj
        do {
            // this creats an audip player obj
            // reqs. a do-try
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            
            // play the selected sound
            audioPlayer?.play()
        }
        // fails-- print error
        catch {
            print("Not able to create audio player object for sound file:\(soundFilename)")
        }
        
        
        
    }
}
