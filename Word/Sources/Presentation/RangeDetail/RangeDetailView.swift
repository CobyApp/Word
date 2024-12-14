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
            
            Button(action: {
                self.store.send(.navigateToQuiz(self.store.level, self.store.range))
            }) {
                Text("퀴즈 시작")
                    .font(.pretendard(size: 16, weight: .bold))
                    .foregroundColor(Color.staticWhite)
                    .padding(.vertical, 16)
                    .frame(maxWidth: .infinity)
                    .background(WordLevel(rawValue: self.store.level)?.color ?? Color.blue40)
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
            }
            .padding(.horizontal, BaseSize.horizantalPadding)
            .padding(.top, 8)
            .padding(.bottom, BaseSize.verticalPadding)
        }
        .background(Color.backgroundNormalAlternative)
        .onAppear {
            self.store.send(.fetchByLevelAndRange(self.store.level, self.store.range))
        }
        .navigationDestination(
            item: self.$store.scope(state: \.quiz, action: \.quiz)
        ) { store in
            QuizView(store: store).navigationBarHidden(true)
        }
    }
}
