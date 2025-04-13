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
            
            // Get ad unit ID from Info.plist
            guard let adUnitID = Bundle.main.object(forInfoDictionaryKey: "GADAdUnitID") as? String else {
                print("⚠️ GADAdUnitID not found in Info.plist")
                return
            }
            
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