import GoogleMobileAds
import ComposableArchitecture

struct AdManager {
    var showInterstitial: @Sendable () async -> Void
}

extension AdManager: DependencyKey {
    static let liveValue = Self(
        showInterstitial: {
            let request = Request()
            // Add test device
            request.testDeviceIdentifiers = ["bd2462f48e2778d8785cd05b0e3145a5"]
            
            guard let adUnitID = Bundle.main.object(forInfoDictionaryKey: "GADAdUnitID") as? String,
                  !adUnitID.isEmpty else {
                print("⚠️ Ad Unit ID is missing or empty")
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
                print("Error loading ad: \(error.localizedDescription)")
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