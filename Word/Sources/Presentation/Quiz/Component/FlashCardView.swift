//
//  FlashCardView.swift
//  Word
//
//  Created by Coby on 12/13/24.
//  Copyright © 2024 Coby. All rights reserved.
//

import SwiftUI

import CobyDS

struct FlashCardView: View {

    @State private var isFlipped: Bool = false
    
    private let word: Word
    
    init(word: Word) {
        self.word = word
    }

    var body: some View {
        ZStack {
            // Front side
            self.frontCard
                .rotation3DEffect(
                    Angle(degrees: self.isFlipped ? 180 : 0),
                    axis: (x: 0, y: 1, z: 0)
                )
                .opacity(self.isFlipped ? 0 : 1)
                .zIndex(self.isFlipped ? 0 : 1)

            // Back side
            self.backCard
                .rotation3DEffect(
                    Angle(degrees: self.isFlipped ? 0 : -180),
                    axis: (x: 0, y: 1, z: 0)
                )
                .opacity(self.isFlipped ? 1 : 0)
                .zIndex(self.isFlipped ? 1 : 0)
        }
        .animation(.interactiveSpring(response: 0.5, dampingFraction: 0.75, blendDuration: 0.1), value: self.isFlipped)
        .onTapGesture {
            self.flipCard()
        }
        .onChange(of: word) {
            self.resetCard()
        }
    }
    
    // Front side view
    private var frontCard: some View {
        ZStack {
            VStack {
                HStack {
                    Spacer()
                    Text("#\(self.word.number)")
                        .font(.pretendard(size: 14, weight: .bold))
                        .foregroundColor(Color.labelAssistive)
                        .padding([.top, .trailing], 16)
                }
                
                Spacer()
            }
            
            Text(self.word.kanji)
                .font(.pretendard(size: 40, weight: .bold))
                .foregroundColor(Color.labelNormal)
        }
        .frame(maxWidth: .infinity, maxHeight: 300)
        .background(Color.backgroundNormalNormal)
        .cornerRadius(16)
        .shadow(color: Color.shadowNormal, radius: 4, x: 0, y: 2)
    }
    
    // Back side view
    private var backCard: some View {
        VStack(spacing: 12) {
            Spacer()
            
            Text(self.word.hiragana)
                .font(.pretendard(size: 24, weight: .medium))
                .foregroundColor(Color.labelNeutral)
            
            Text(self.word.meaning)
                .font(.pretendard(size: 18, weight: .medium))
                .foregroundColor(Color.labelAlternative)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: 300)
        .background(Color.backgroundNormalNormal)
        .cornerRadius(16)
        .shadow(color: Color.shadowNormal, radius: 4, x: 0, y: 2)
    }
    
    // Reset card to front side
    private func resetCard() {
        withAnimation {
            self.isFlipped = false
        }
    }
    
    // Flip the card
    private func flipCard() {
        withAnimation(.spring(response: 0.6, dampingFraction: 0.8, blendDuration: 0.2)) {
            self.isFlipped.toggle()
        }
    }
}
