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
        init() {}
    }
    
    enum Action: Equatable {
        case navigateToRangeDetail(String, Int)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .navigateToRangeDetail:
                return .none
            }
        }
    }
}
