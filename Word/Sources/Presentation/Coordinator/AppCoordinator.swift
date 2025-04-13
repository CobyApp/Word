import SwiftUI
import ComposableArchitecture

@Reducer
struct AppCoordinator {
    @ObservableState
    struct State: Equatable {
        var path: StackState<Path.State> = StackState()
        var home: HomeStore.State
        
        init(home: HomeStore.State = .init()) {
            self.home = home
        }
    }
    
    enum Action {
        case path(StackAction<Path.State, Path.Action>)
        case home(HomeStore.Action)
        case resetNavigation
    }
    
    @Reducer(state: .equatable)
    enum Path {
        case rangeDetail(RangeDetailStore)
        case quiz(QuizStore)
        case final(FinalStore)
    }
    
    var body: some ReducerOf<Self> {
        Scope(state: \.home, action: \.home) {
            HomeStore()
        }
        
        Reduce { state, action in
            switch action {
            case let .home(.navigateToRangeDetail(level, range)):
                state.path.append(.rangeDetail(.init(level: level, range: range)))
                return .none
                
            case let .path(.element(id: _, action: .rangeDetail(.navigateToQuiz(level, range)))):
                state.path.append(.quiz(.init(level: level, range: range)))
                return .none
                
            case let .path(.element(id: _, action: .quiz(.navigateToFinal(words)))):
                state.path.append(.final(.init(words: words)))
                return .none
                
            case .path(.element(id: _, action: .final(.exitToHome))):
                state.path = StackState()
                return .none
                
            case .resetNavigation:
                state.path = StackState()
                return .none
                
            case .path:
                return .none
            }
        }
        .forEach(\.path, action: \.path) {
            Path.body
        }
    }
}

struct AppCoordinatorView: View {
    @Bindable var store: StoreOf<AppCoordinator>
    
    var body: some View {
        NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
            HomeView(store: store.scope(state: \.home, action: \.home))
        } destination: { store in
            switch store.case {
            case let .rangeDetail(store):
                RangeDetailView(store: store)
            case let .quiz(store):
                QuizView(store: store)
            case let .final(store):
                FinalView(store: store)
            }
        }
    }
} 
