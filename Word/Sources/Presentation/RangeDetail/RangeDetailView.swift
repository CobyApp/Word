//
//  RangeDetailView.swift
//  Word
//
//  Created by Coby on 12/13/24.
//  Copyright © 2024 Coby. All rights reserved.
//

import SwiftUI
import SwiftData

import CobyDS
import ComposableArchitecture

struct RangeDetailView: View {
    
    @Bindable private var store: StoreOf<RangeDetailStore>
    
    init(store: StoreOf<RangeDetailStore>) {
        self.store = store
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Top Bar
            TopBarView(
                leftAction: { self.store.send(.dismiss) },
                title: "Stage \(self.store.range + 1)"
            )
            
            // Word List
            ScrollView {
                LazyVStack(spacing: 8) {
                }
                .padding(.horizontal, 16)
            }
            .background(Color.backgroundNormalAlternative)
        }
        .onAppear {
            self.store.send(.fetchByLevelAndRange(self.store.level, self.store.range))
        }
    }
}

struct WordRow: View {
    let word: Word
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(word.kanji)
                .font(.pretendard(size: 18, weight: .bold))
                .foregroundColor(.primary)
            Text("\(word.hiragana) - \(word.meaning)")
                .font(.pretendard(size: 14, weight: .medium))
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
        .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 1)
    }
}
