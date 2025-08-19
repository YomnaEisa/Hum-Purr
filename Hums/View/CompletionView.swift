import SwiftUI

struct CompletionView: View {
    @StateObject private var musicPlayer = BackgroundMusicPlayer.shared

    var body: some View {
        NavigationStack { // Wrap the entire view in a NavigationStack
            ZStack {
                // Background Photo
                Image("CompletionImage") // Replace with your photo name
                    .resizable()
                    .ignoresSafeArea()

                // Main content
                VStack {
                    // Exit button at the top center
                    NavigationLink(destination: LandingView()) {
                        Image("ExitButton") // Replace with your image name
                            .resizable()
                            .frame(width: 450, height: 140)
                            .padding(10)
                    }
                    .padding(.top, 20) // Add some padding at the top

                    Spacer() // Push everything else to the bottom

                    // Mute button at the bottom
                    Button(action: {
                        musicPlayer.toggleMute()
                    }) {
                        Image(systemName: musicPlayer.isMuted ? "speaker.slash.fill" : "speaker.wave.2.fill")
                            .font(.system(size: 24))
                            .foregroundColor(.brown)
                            .padding()
                    }
                    .padding(.bottom, 900) // Add some padding at the bottom
                }
            }
        }
    }
}

#Preview {
    CompletionView()
}
