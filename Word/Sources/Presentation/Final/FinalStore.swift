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
        let level: String
        let range: Int
        let currentOffset: Int
        
        var isLastSet: Bool {
            let startNumber = range * 100 + 1
            let endNumber = (range + 1) * 100
            let currentNumber = startNumber + currentOffset
            return currentNumber + 10 > endNumber
        }
        
        init(words: [Word], level: String, range: Int, currentOffset: Int) {
            self.words = words
            self.level = level
            self.range = range
            self.currentOffset = currentOffset
        }
    }
    
    enum Action: Equatable {
        case retryQuiz
        case nextQuiz
        case dismiss
        case exitToHome
    }
    
    @Dependency(\.dismiss) private var dismiss
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .retryQuiz:
                return .send(.dismiss)
                
            case .nextQuiz:
                return .none
                
            case .dismiss:
                return .run { _ in await self.dismiss() }
                
            case .exitToHome:
                return .none
            }
        }
    }
}
