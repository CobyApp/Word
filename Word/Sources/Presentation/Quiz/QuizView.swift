//
//  QuizView.swift
//  Word
//
//  Created by Coby on 12/13/24.
//  Copyright © 2024 Coby. All rights reserved.
//

import SwiftUI

import CobyDS
import ComposableArchitecture

struct QuizView: View {
    
    @Bindable private var store: StoreOf<QuizStore>
    
    init(store: StoreOf<QuizStore>) {
        self.store = store
    }
    
    var body: some View {
        VStack(spacing: 0) {
            TopBarView(
                leftAction: { self.store.send(.dismiss) },
                title: "Stage \(self.store.range + 1)"
            )
            
            Spacer()
            
            // Flashcard View
            if let word = store.currentWord {
                FlashCardView(word: word)
                    .padding()
            } else {
                Text("No words available")
                    .font(.pretendard(size: 16, weight: .bold))
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            // Navigation Buttons
            HStack {
                Button(action: { self.store.send(.previousWord) }) {
                    Text("이전")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                
                Button(action: { self.store.send(.nextWord) }) {
                    Text("다음")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
            }
            .padding(.horizontal)
        }
        .background(Color.backgroundNormalAlternative)
        .onAppear {
            self.store.send(.fetchByLevelAndRange(self.store.level, self.store.range))
        }
    }
}
