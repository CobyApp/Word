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
        let range: String
        
        init(level: String, range: String) {
            self.level = level
            self.range = range
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
