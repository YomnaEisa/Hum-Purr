import SwiftUI
import AVKit

struct ExerciseView: View {
    @StateObject private var viewModel = videoPlayerViewModel()
    @StateObject private var appState = AppState()
    @StateObject private var musicPlayer = BackgroundMusicPlayer.shared
    @State private var videoOpacity: Double = 1.0
    @State private var isVideoCompleted: Bool = false
    @State private var isExerciseCompleted: Bool = false 

    private var confidence: Double {
        return appState.detectionStates.first?.1.currentConfidence ?? 0.0
    }

    private enum Constants {
        static let iconSize: CGFloat = 24
        static let exitButtonWidth: CGFloat = 100
        static let exitButtonHeight: CGFloat = 70
        static let micButtonSize: CGFloat = 200
        static let buttonPadding: CGFloat = 50
        static let animationDuration: Double = 1.0
    }

    var body: some View {
        NavigationStack {
            ZStack {
                // Video Player View
                VideoPlayer(
                    currentVideo: viewModel.currentVideo,
                    confidence: confidence,
                    isVideoCompleted: $isVideoCompleted
                )
                .ignoresSafeArea()
                .animation(.easeInOut(duration: Constants.animationDuration), value: videoOpacity)

                // Top-right buttons (mute and exit/next)
                VStack {
                    HStack {
                        Spacer()

                        // Mute Button
                        Button(action: musicPlayer.toggleMute) {
                            Image(systemName: musicPlayer.isMuted ? "speaker.slash.fill" : "speaker.wave.2.fill")
                                .font(.system(size: Constants.iconSize))
                                .foregroundColor(.white)
                                .padding()
                        }

                        // Exit/Next Button
                        if viewModel.isLastVideo {
                            Button(action: { isExerciseCompleted = true }) {
                                Image(isVideoCompleted ? "ExitButton" : "exitButtonDisabled")
                                    .resizable()
                                    .frame(width: Constants.exitButtonWidth, height: Constants.exitButtonHeight)
                                    .padding(Constants.buttonPadding)
                            }
                            .disabled(!isVideoCompleted)
                        } else {
                            Button(action: {
                                viewModel.nextVideo()
                                isVideoCompleted = false
                            }) {
                                Image(isVideoCompleted ? "nextButton" : "nextButtonDisabled")
                                    .resizable()
                                    .frame(width: Constants.exitButtonWidth, height: Constants.exitButtonHeight)
                                    .padding(Constants.buttonPadding)
                            }
                            .disabled(!isVideoCompleted)
                        }
                    }

                    Spacer()

                    // Mic Button and Confidence Text
                    VStack {
                        Button(action: toggleMic) {
                            Image(viewModel.isMicOn ? viewModel.currentVideo.micOnImage : viewModel.currentVideo.micOffImage)
                                .resizable()
                                .frame(width: Constants.micButtonSize, height: Constants.micButtonSize)
                        }

                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationDestination(isPresented: $isExerciseCompleted) {
                CompletionView() // Navigate to the next screen
            }
        }
    }

    private func toggleMic() {
        if appState.soundDetectionIsRunning {
            appState.soundDetectionIsRunning = false
            viewModel.isMicOn = false
            SystemAudioClassifier.singleton.stopSoundClassification()
        } else {
            viewModel.isMicOn = true
            let config = AppConfiguration()
            appState.restartDetection(config: config)
        }
    }
}

#Preview {
    ExerciseView()
}
