//
//  HomeStore.swift
//  Word
//
//  Created by Coby on 12/12/24.
//  Copyright © 2024 Coby. All rights reserved.
//

import Foundation

import ComposableArchitecture

@Reducer
struct HomeStore: Reducer {
    
    @ObservableState
    struct State: Equatable {
    }
    
    enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .binding:
                return .none
            }
        }
    }
}
