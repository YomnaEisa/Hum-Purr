import SwiftUI
import AVKit

struct OnboardingVideoPlayer: UIViewControllerRepresentable {
    var videoName: String

    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.showsPlaybackControls = false
        controller.videoGravity = .resizeAspectFill

        // Load the video from the app bundle
        guard let path = Bundle.main.path(forResource: videoName, ofType: "mov") else {
            print("Onboarding video file not found: \(videoName)")
            return controller
        }

        // Create an AVPlayer with the video URL
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        controller.player = player

        // Store the player in the coordinator to retain it
        context.coordinator.player = player

        // Play the video
        player.play()

        return controller
    }

    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        // Update the player when the videoName changes
        guard let player = context.coordinator.player else { return }

        // Load the new video
        guard let path = Bundle.main.path(forResource: videoName, ofType: "mov") else {
            print("Onboarding video file not found: \(videoName)")
            return
        }

        let newPlayerItem = AVPlayerItem(url: URL(fileURLWithPath: path))
        player.replaceCurrentItem(with: newPlayerItem)

        // Play the new video
        player.play()
    }

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    class Coordinator: NSObject {
        var player: AVPlayer?
    }
}
