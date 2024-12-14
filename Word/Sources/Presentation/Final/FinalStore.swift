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
    
    enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case dismiss
    }
    
    @Dependency(\.dismiss) private var dismiss
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .binding:
                return .none
                
            case .dismiss:
                return .run { _ in await self.dismiss() }
            }
        }
    }
}
