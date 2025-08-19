import SwiftUI

struct OnboardingView: View {
    @StateObject private var onboardingViewModel = OnboardingVideoPlayerViewModel()
    @State private var startExercise: Bool = false
    @StateObject private var musicPlayer = BackgroundMusicPlayer.shared


    var body: some View {
        NavigationStack{
        ZStack {
            // Onboarding Video Player
            OnboardingVideoPlayer(videoName: onboardingViewModel.currentOnboardingVideoName)
                .edgesIgnoringSafeArea(.all) // Make the video player full screen
            
            // Onboarding Navigation Buttons
            VStack {
                HStack {
                    
                    Button(action: {
                        musicPlayer.toggleMute()
                    }) {
                        Image(systemName: musicPlayer.isMuted ? "speaker.slash.fill" : "speaker.wave.2.fill")
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                            .padding()
                    }
                    
                    // Skip Button
                    Button(action: {
                        onboardingViewModel.skipToLastVideo()
                    }) {
                        Image(onboardingViewModel.currentVideoIndex == onboardingViewModel.onboardingVideoNames.count - 1 ? "skipButtonDisabled" :"skipButton")
                            .resizable()
                            .frame(width: 100, height: 50)
                            .padding(10)
                    }
                    .disabled(onboardingViewModel.currentVideoIndex == onboardingViewModel.onboardingVideoNames.count - 1)
                    
                    
                    // Previous Button with Image
                    Button(action: {
                        onboardingViewModel.goToPreviousVideo()
                    }) {
                        Image(onboardingViewModel.currentVideoIndex == 0 ? "backButtonDisabled" : "backButton") // Replace with your image name
                            .resizable()
                            .frame(width: 100, height: 50)
                            .padding(10)
                    }
                    .disabled(onboardingViewModel.currentVideoIndex == 0)
                    
                    Spacer()
                    
                    // Next Button with Image
                    Button(action: {
                        onboardingViewModel.goToNextVideo()
                    }) {
                        Image(onboardingViewModel.currentVideoIndex == onboardingViewModel.onboardingVideoNames.count - 1 ? "nextButtonDisabled" :"nextButton")
                            .resizable()
                            .frame(width: 100, height: 50)
                            .padding(10)
                    }
                    .disabled(onboardingViewModel.currentVideoIndex == onboardingViewModel.onboardingVideoNames.count - 1)
                    
                    
                    
                    if onboardingViewModel.currentVideoIndex == onboardingViewModel.onboardingVideoNames.count - 1 {
                        
                        Button(action: {
                            startExercise = true
                        }) {
                            Image("startButton")
                                .resizable()
                                .frame(width: 100, height: 50)
                                .padding(10)
                        }
                        
                    }
                    
                   
                    
                    
                }
                .padding()
                .background(Color.black.opacity(0.2)) // Semi-transparent background for better visibility
                .cornerRadius(15)
                
                Spacer()
            }
        }
        .navigationDestination(isPresented: $startExercise) {
            ExerciseView()
        }
    } // end of nav stack
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    OnboardingView()
}
