import SwiftUI

struct LandingView: View {
    @StateObject private var musicPlayer = BackgroundMusicPlayer.shared

    var body: some View {
        NavigationStack {
            ZStack {
                // Background Photo
                Image("landingWithTitle") 
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()

                // Button to Navigate to Onboarding
                VStack {
                    Button(action: {
                        musicPlayer.toggleMute()
                    }) {
                        Image(systemName: musicPlayer.isMuted ? "speaker.slash.fill" : "speaker.wave.2.fill")
                            .font(.system(size: 24))
                            .foregroundColor(.brown)
                            .padding()
                    }
                       
                    
                    Spacer()
                    NavigationLink(destination: OnboardingView()) {
                        Image("startButton")
                            .resizable()
                            .frame(width: 450, height: 140)
                            .padding(10)
                    }
                    .padding(.bottom, 20) // Add some padding at the bottom
                    .navigationBarBackButtonHidden(true)
                }
            }
        }
    }
}

