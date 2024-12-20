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
                title: "헷갈린 단어"
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
            
            Spacer()
            
            Button(action: { self.store.send(.retryQuiz) }) {
                Text("다시하기")
                    .font(.pretendard(size: 16, weight: .bold))
                    .foregroundColor(Color.inverseLabel)
                    .padding(.vertical, 16)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue60)
                    .cornerRadius(12)
                    .shadow(color: Color.shadowNormal, radius: 4, x: 0, y: 2)
            }
            .padding(.horizontal, BaseSize.horizantalPadding)
            .padding(.top, 8)
            .padding(.bottom, BaseSize.verticalPadding)
        }
        .background(Color.backgroundNormalAlternative)
    }
}
