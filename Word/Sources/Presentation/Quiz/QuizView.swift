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
            // 상단 타이틀
            TopBarView(
                leftAction: { self.store.send(.dismiss) },
                title: "퀴즈 \(self.store.currentOffset / 10 + 1) / 10"
            )
            
            // 상단 진행 상황 막대
            ProgressBarView(
                progress: self.store.progress,
                backgroundColor: Color.coolNeutral95,
                foregroundColor: WordLevel(rawValue: self.store.level)?.color ?? Color.blue40
            )
            .padding(.horizontal, BaseSize.horizantalPadding)
            .padding(.top, 16)
            
            Spacer()
            
            // 플래시카드 뷰
            if let word = store.currentWord {
                FlashCardView(
                    word: word,
                    onRemembered: { self.store.send(.didRemember) },
                    onForgotten: { self.store.send(.didNotRemember) }
                )
                .padding(.horizontal, BaseSize.horizantalPadding)
            } else {
                Text("No words available")
                    .font(.pretendard(size: 16, weight: .bold))
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            HStack {
                Button(action: { self.store.send(.didNotRemember) }) {
                    Text("모르겠음")
                        .font(.pretendard(size: 16, weight: .bold))
                        .foregroundColor(Color.inverseLabel)
                        .padding(.vertical, 16)
                        .frame(maxWidth: .infinity)
                        .background(Color.red60)
                        .cornerRadius(12)
                        .shadow(color: Color.shadowNormal, radius: 4, x: 0, y: 2)
                }
                
                Button(action: { self.store.send(.didRemember) }) {
                    Text("외웠음")
                        .font(.pretendard(size: 16, weight: .bold))
                        .foregroundColor(Color.inverseLabel)
                        .padding(.vertical, 16)
                        .frame(maxWidth: .infinity)
                        .background(Color.green60)
                        .cornerRadius(12)
                        .shadow(color: Color.shadowNormal, radius: 4, x: 0, y: 2)
                }
            }
            .padding(.horizontal, BaseSize.horizantalPadding)
            .padding(.top, 8)
            .padding(.bottom, BaseSize.verticalPadding)
        }
        .background(Color.backgroundNormalAlternative)
        .navigationBarHidden(true)
        .onAppear {
            self.store.send(.fetchByLevelAndRange(self.store.level, self.store.range))
        }
    }
}
