import SwiftUI

import CobyDS

@main
struct WordApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .loadCustomFonts()
        }
    }
}
