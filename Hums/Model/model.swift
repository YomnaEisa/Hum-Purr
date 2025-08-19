//
//  model.swift
//  My App
//
//  Created by Yomna Eisa on 19/02/2025.
//

import AVKit
import SwiftUI

// This struct connects the video animations with the texts to display on the screen with it

struct VideoData{
    let videoName: String
    let micOnImage: String
    let micOffImage: String
}

struct onboardingvideoData{
    let videoName: [String]
    var currentVideoIndex: Int = 0
    
    var currentVideoName: String {
        videoName[currentVideoIndex]
    }
}

struct videoPlayerModel{
    var player: AVQueuePlayer?
    var isPlaying: Bool = true
    var isRecording: Bool = false
    var currentIndex = 0
   // var videoTextPairs: [videoTextPairs] = []
}
