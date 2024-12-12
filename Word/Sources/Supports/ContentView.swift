import SwiftUI

import CobyDS
import ComposableArchitecture

struct ContentView: View {

    var body: some View {
        NavigationStack {
            HomeView(store: Store(initialState: HomeStore.State()) {
                HomeStore()
            })
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
