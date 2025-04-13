import SwiftUI
import ComposableArchitecture
import GoogleMobileAds
import CobyDS

@main
struct WordApp: App {
    init() {
        // Configure test devices
        MobileAds.shared.requestConfiguration.testDeviceIdentifiers = ["bd2462f48e2778d8785cd05b0e3145a5"]
        
        // Initialize MobileAds
        if let applicationID = Bundle.main.object(forInfoDictionaryKey: "GADApplicationIdentifier") as? String {
            print("Initializing MobileAds with application ID: \(applicationID)")
            MobileAds.shared.start { status in
                print("✅ AdMob started: \(status.adapterStatusesByClassName)")
            }
        } else {
            print("⚠️ GADApplicationIdentifier not found in Info.plist")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            AppCoordinatorView(
                store: Store(
                    initialState: AppCoordinator.State(),
                    reducer: { AppCoordinator() }
                )
            )
            .loadCustomFonts()
        }
    }
}
