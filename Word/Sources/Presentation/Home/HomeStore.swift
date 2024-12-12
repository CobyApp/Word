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
        @Presents var rangeDetail: RangeDetailStore.State?
    }
    
    enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case rangeDetail(PresentationAction<RangeDetailStore.Action>)
        case presentRangeDetail(String, String)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .binding:
                return .none
            case .rangeDetail:
                return .none
            case .presentRangeDetail(let level, let range):
                state.rangeDetail = RangeDetailStore.State(level: level, range: range)
                return .none
            }
        }
        .ifLet(\.$rangeDetail, action: \.rangeDetail) {
            RangeDetailStore()
        }
    }
}
