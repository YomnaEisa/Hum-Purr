import SwiftUI
import AVKit

struct VideoPlayer: UIViewControllerRepresentable {
    var currentVideo: VideoData
    var confidence: Double
    @Binding var isVideoCompleted: Bool

    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.showsPlaybackControls = false
        controller.videoGravity = .resizeAspectFill

        // Load the video from the app bundle
        guard let path = Bundle.main.path(forResource: currentVideo.videoName, ofType: "mov") else {
            print("Video file not found: \(currentVideo.videoName)")
            return controller
        }

        // Create an AVPlayer with the video URL
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        controller.player = player

        // Store the player in the coordinator to retain it
        context.coordinator.player = player

        // Add a time observer to track video progress
        let interval = CMTime(seconds: 0.5, preferredTimescale: CMTimeScale(NSEC_PER_SEC)) // Check every 0.5 seconds
        context.coordinator.timeObserver = player.addPeriodicTimeObserver(
            forInterval: interval,
            queue: .main
        ) { time in
            // Check if the video has reached the end
            if time >= player.currentItem?.duration ?? .zero {
                context.coordinator.videoDidFinish()
            }
        }

        // Play the video if confidence is >= 70%
        if confidence >= 0.7 {
            player.play()
        }

        return controller
    }

    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        guard let player = context.coordinator.player else { return }

        // Reload the video if the current video has changed
        if context.coordinator.currentVideoName != currentVideo.videoName {
            context.coordinator.currentVideoName = currentVideo.videoName

            // Load the new video
            guard let path = Bundle.main.path(forResource: currentVideo.videoName, ofType: "mov") else {
                print("Video file not found: \(currentVideo.videoName)")
                return
            }

            let newPlayerItem = AVPlayerItem(url: URL(fileURLWithPath: path))
            player.replaceCurrentItem(with: newPlayerItem)

            // Play the new video if confidence is >= 70%
            if confidence >= 0.7 {
                player.play()
            }
        }

        // Control playback based on confidence
        if confidence >= 0.7, player.timeControlStatus != .playing {
            player.play()
        } else if confidence < 0.7, player.timeControlStatus != .paused {
            player.pause()
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(isVideoCompleted: $isVideoCompleted)
    }

    class Coordinator: NSObject {
        var player: AVPlayer?
        var currentVideoName: String?
        var timeObserver: Any?
        @Binding var isVideoCompleted: Bool

        init(isVideoCompleted: Binding<Bool>) {
            self._isVideoCompleted = isVideoCompleted
        }

        deinit {
            // Remove the time observer when the coordinator is deallocated
            if let timeObserver = timeObserver {
                player?.removeTimeObserver(timeObserver)
            }
        }

        func videoDidFinish() {
            print("Video finished playing") 
            isVideoCompleted = true
        }
    }
}
