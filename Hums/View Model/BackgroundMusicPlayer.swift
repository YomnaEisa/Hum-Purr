import Foundation
import AVFoundation

class BackgroundMusicPlayer: ObservableObject {
    static let shared = BackgroundMusicPlayer() // Singleton instance
    private var audioPlayer: AVAudioPlayer?

    @Published var isMuted: Bool = false {
        didSet {
            if isMuted {
                audioPlayer?.pause()
            } else {
                audioPlayer?.play()
            }
        }
    }

    private init() {
        // Load the background music file
        if let path = Bundle.main.path(forResource: "backgroundMusic", ofType: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                audioPlayer?.numberOfLoops = -1 // Loop indefinitely
                audioPlayer?.volume = 0.5 // Set volume (0.0 to 1.0)
                audioPlayer?.play()
            } catch {
                print("Failed to load background music: \(error)")
            }
        } else {
            print("Background music file not found")
        }
    }

    func toggleMute() {
        isMuted.toggle()
    }
}
