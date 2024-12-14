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
                title: "퀴즈"
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
            
            // Buttons
            HStack {
                // 모르겠음 버튼
                Button(action: { self.store.send(.didNotRemember) }) {
                    Text("모르겠음")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                
                // 외웠음 버튼
                Button(action: { self.store.send(.didRemember) }) {
                    Text("외웠음")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green.opacity(0.8))
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
        .navigationDestination(
            item: self.$store.scope(state: \.final, action: \.final)
        ) { store in
            FinalView(store: store).navigationBarHidden(true)
        }
    }
}
