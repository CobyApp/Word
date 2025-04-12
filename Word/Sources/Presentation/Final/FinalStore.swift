//
//  FinalStore.swift
//  Word
//
//  Created by Coby on 12/14/24.
//  Copyright © 2024 Coby. All rights reserved.
//

import Foundation
import ComposableArchitecture

@Reducer
struct FinalStore: Reducer {
    @ObservableState
    struct State: Equatable {
        var words: [Word] = []
        
        init(words: [Word]) {
            self.words = words
        }
    }
    
    enum Action: Equatable {
        case retryQuiz
        case dismiss
        case exitToHome
    }
    
    @Dependency(\.dismiss) private var dismiss
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .retryQuiz:
                return .send(.dismiss)
                
            case .dismiss:
                return .run { _ in await self.dismiss() }
                
            case .exitToHome:
                return .none
            }
        }
    }
}
