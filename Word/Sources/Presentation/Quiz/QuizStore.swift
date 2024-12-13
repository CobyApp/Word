//
//  QuizStore.swift
//  Word
//
//  Created by Coby on 12/13/24.
//  Copyright © 2024 Coby. All rights reserved.
//

import Foundation

import ComposableArchitecture

@Reducer
struct QuizStore: Reducer {
    
    @ObservableState
    struct State: Equatable {
        let level: String
        let range: Int
        var words: [Word] = []
        
        init(level: String, range: Int) {
            self.level = level
            self.range = range
        }
    }
    
    enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case fetchByLevelAndRange(String, Int)
        case fetchByLevelAndRangeResponse(TaskResult<[Word]>)
        case dismiss
    }
    
    @Dependency(\.dismiss) private var dismiss
    @Dependency(\.wordData) private var wordContext
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .binding:
                return .none
            case .fetchByLevelAndRange(let level, let range):
                return .run { send in
                    let result = await TaskResult {
                        try self.wordContext.fetchByLevelAndRange(level, range)
                    }
                    await send(.fetchByLevelAndRangeResponse(result))
                }
            case let .fetchByLevelAndRangeResponse(.success(words)):
                state.words = words
                print(words)
                return .none
            case let .fetchByLevelAndRangeResponse(.failure(error)):
                print(error.localizedDescription)
                return .none
            case .dismiss:
                return .run { _ in await self.dismiss() }
            }
        }
    }
}
