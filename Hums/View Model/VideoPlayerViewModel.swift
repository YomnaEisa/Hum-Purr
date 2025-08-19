import AVKit
import Combine
import SwiftUI

class videoPlayerViewModel: ObservableObject {
    @Published var model : videoPlayerModel = videoPlayerModel()
    
    @Published var currentVideoIndex: Int = 0
    @Published var isMicOn = false
    @State private var player: AVQueuePlayer?

    private var playerLooper: AVPlayerLooper?
    
    @Published var isVideoCompleted: Bool = false
    
    let videos: [VideoData] = [
        VideoData(videoName: "FillingHeart", micOnImage: "heartMicOn", micOffImage: "heartMicOff"),
        VideoData(videoName: "FlowerBlooming", micOnImage: "flowerMicOn", micOffImage: "flowerMicOff"),
        VideoData(videoName: "MoonPhases", micOnImage: "moonMicOn", micOffImage: "moonMicOff")]
    
    var currentVideo: VideoData {
        return videos[currentVideoIndex]
    }
    
    var isLastVideo: Bool {
        currentVideoIndex == videos.count - 1
    }
    
    func nextVideo() {
        if currentVideoIndex < videos.count - 1 {
            currentVideoIndex += 1
            isVideoCompleted = false
        } else {
            currentVideoIndex = 0
        }
    }
        
    init(){
        
        setupPlayer()
    }
    
    private func setupPlayer() {
        guard let path = Bundle.main.path(forResource: currentVideo.videoName, ofType: "mov") else {
            fatalError("Video file not found")
        }
        
        let playerItem = AVPlayerItem(url: URL(fileURLWithPath: path))
        model.player = AVQueuePlayer(playerItem: playerItem)
        playerLooper = AVPlayerLooper(player: model.player!, templateItem: playerItem)
    }
    
    
    func togglePlayback(){
        isMicOn.toggle()
            if isMicOn{
                player?.play()
            } else{
                player?.pause()
            }
        }
    }
    
