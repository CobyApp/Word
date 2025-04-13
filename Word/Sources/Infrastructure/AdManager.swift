import GoogleMobileAds
import ComposableArchitecture

struct AdManager {
    var showInterstitial: @Sendable () async -> Void
}

extension AdManager: DependencyKey {
    static let liveValue = Self(
        showInterstitial: {
            let request = Request()
            request.keywords = ["education", "language", "learning"]
            
            // Use test ad unit ID during development
            let adUnitID = "ca-app-pub-3940256099942544/4411468910" // Test ad unit ID
            
            print("Loading ad with unit ID: \(adUnitID)")
            
            do {
                let ad = try await InterstitialAd.load(
                    with: adUnitID,
                    request: request
                )
                
                print("Ad loaded successfully")
                if let windowScene = await UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let rootViewController = await windowScene.windows.first?.rootViewController {
                    print("Presenting ad")
                    await MainActor.run {
                        ad.present(from: rootViewController)
                    }
                } else {
                    print("Failed to get root view controller")
                }
            } catch {
                print("Error loading ad: \(error)")
                print("Error description: \(error.localizedDescription)")
            }
        }
    )
}

extension DependencyValues {
    var adManager: AdManager {
        get { self[AdManager.self] }
        set { self[AdManager.self] = newValue }
    }
} 