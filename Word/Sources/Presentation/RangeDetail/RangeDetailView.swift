//
//  RangeDetailView.swift
//  Word
//
//  Created by Coby on 12/13/24.
//  Copyright © 2024 Coby. All rights reserved.
//

import SwiftUI

import CobyDS
import ComposableArchitecture

struct RangeDetailView: View {
    
    @Bindable private var store: StoreOf<RangeDetailStore>
    
    init(store: StoreOf<RangeDetailStore>) {
        self.store = store
    }
    
    var body: some View {
        VStack {
            VStack(spacing: 0) {
                TopBarView(
                    leftAction: { self.store.send(.dismiss) },
                    title: self.store.range
                )
            }
            
            Spacer()
        }
        .background(Color.backgroundNormalAlternative)
    }
}
