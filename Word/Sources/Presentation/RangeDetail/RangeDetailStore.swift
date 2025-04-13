//
//  RangeDetailStore.swift
//  Word
//
//  Created by Coby on 12/13/24.
//  Copyright © 2024 Coby. All rights reserved.
//

import Foundation
import ComposableArchitecture

@Reducer
struct RangeDetailStore: Reducer {
    @ObservableState
    struct State: Equatable {
        let level: String
        let range: Int
        var words: [Word] = []
        var hasShownAd: Bool = false
        
        init(level: String, range: Int) {
            self.level = level
            self.range = range
        }
    }
    
    enum Action: Equatable {
        case onAppear
        case fetchByLevelAndRange(String, Int)
        case fetchByLevelAndRangeResponse(TaskResult<[Word]>)
        case navigateToQuiz(String, Int)
        case dismiss
    }
    
    @Dependency(\.dismiss) private var dismiss
    @Dependency(\.wordData) private var wordContext
    @Dependency(\.adManager) private var adManager
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                if !state.hasShownAd {
                    print("RangeDetailStore: Showing ad")
                    state.hasShownAd = true
                    return .run { _ in
                        await adManager.showInterstitial()
                    }
                }
                return .none
                
            case .navigateToQuiz:
                return .none
                
            case .fetchByLevelAndRange(let level, let range):
                print("Fetching words for level: \(level), range: \(range)")
                return .run { send in
                    let result = await TaskResult {
                        try self.wordContext.fetchByLevelAndRange(level, range, 0)
                    }
                    await send(.fetchByLevelAndRangeResponse(result))
                }
                
            case let .fetchByLevelAndRangeResponse(.success(words)):
                print("Successfully fetched \(words.count) words")
                state.words = words
                return .none
                
            case let .fetchByLevelAndRangeResponse(.failure(error)):
                print("Error fetching words: \(error.localizedDescription)")
                return .none
                
            case .dismiss:
                return .run { _ in await self.dismiss() }
            }
        }
    }
}
