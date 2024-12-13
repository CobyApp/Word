import SwiftUI
import SwiftData

import CobyDS

@main
struct WordApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .loadCustomFonts()
                .onAppear {
                    self.initializeDataIfNeeded()
                }
        }
    }
    
    // 데이터 초기화 함수
    private func initializeDataIfNeeded() {
        let userDefaultsKey = "isDataInitialized"
        
        // 이미 데이터가 초기화된 경우 실행하지 않음
        if UserDefaults.standard.bool(forKey: userDefaultsKey) {
            print("Data already initialized")
            return
        }
        
        // 데이터 초기화
        DataInitializer.initializeDataIfNeeded(context: sharedContext)
    }
}
