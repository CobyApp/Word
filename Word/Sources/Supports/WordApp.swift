import SwiftUI
import ComposableArchitecture

import CobyDS

@main
struct WordApp: App {
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
