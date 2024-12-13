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
        VStack(spacing: 0) {
            TopBarView(
                leftAction: { self.store.send(.dismiss) },
                title: "Stage \(self.store.range + 1)"
            )
            
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(self.store.words, id: \.id) { word in
                        WordRowView(word: word)
                            .padding(.horizontal, BaseSize.horizantalPadding)
                    }
                }
                .padding(.vertical, BaseSize.verticalPadding)
            }
            .background(Color.backgroundNormalAlternative)
        }
        .onAppear {
            self.store.send(.fetchByLevelAndRange(self.store.level, self.store.range))
        }
    }
}


