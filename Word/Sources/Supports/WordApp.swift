import SwiftUI
import SwiftData

import CobyDS

@main
struct WordApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .loadCustomFonts()
                .modelContainer(for: Word.self)
        }
    }
}
