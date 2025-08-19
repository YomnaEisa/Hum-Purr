import Foundation

class OnboardingVideoPlayerViewModel: ObservableObject {
    
    
    let onboardingVideoNames: [String] = ["OnboardingFafo-1", "OnboardingFafo-2", "OnboardingFafo-3","OnboardingFafo-4", "OnboardingFafo-5", "OnboardingFafo-6","OnboardingFafo-7", "OnboardingFafo-8", "OnboardingKako-9", "OnboardingKako-10", "OnboardingKako-11","OnboardingKako-12","OnboardingKako-13" ]
    @Published var currentVideoIndex: Int = 0

    var currentOnboardingVideoName: String {
        onboardingVideoNames[currentVideoIndex]
    }

    
    func goToPreviousVideo() {
        print("Previous button tapped. Current index: \(currentVideoIndex)")
        if currentVideoIndex > 0 {
            currentVideoIndex -= 1
            print("New index: \(currentVideoIndex)")
        }
    }

    func goToNextVideo() {
        print("Next button tapped. Current index: \(currentVideoIndex)")
        if currentVideoIndex < onboardingVideoNames.count - 1 {
            currentVideoIndex += 1
            print("New index: \(currentVideoIndex)")
        }
    }

    func skipToLastVideo() {
        print("Skip button tapped. Current index: \(currentVideoIndex)")
        currentVideoIndex = onboardingVideoNames.count - 1
        print("New index: \(currentVideoIndex)")
    }
}
