//
//  FinalView.swift
//  Word
//
//  Created by Coby on 12/14/24.
//  Copyright © 2024 Coby. All rights reserved.
//

import SwiftUI

import CobyDS
import ComposableArchitecture

struct FinalView: View {
    
    @Bindable private var store: StoreOf<FinalStore>
    
    init(store: StoreOf<FinalStore>) {
        self.store = store
    }
    
    var body: some View {
        VStack(spacing: 0) {
            TopBarView(
                leftAction: { self.store.send(.dismiss) },
                title: "퀴즈 결과"
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
        }
        .background(Color.backgroundNormalAlternative)
    }
}
