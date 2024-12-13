//
//  FlashCardView.swift
//  Word
//
//  Created by Coby on 12/13/24.
//  Copyright © 2024 Coby. All rights reserved.
//

import SwiftUI

struct FlashCardView: View {
    let word: Word
    @State private var isFlipped: Bool = false

    var body: some View {
        ZStack {
            // Front side
            frontCard
                .rotation3DEffect(
                    Angle(degrees: self.isFlipped ? 180 : 0),
                    axis: (x: 0, y: 1, z: 0)
                )
                .opacity(self.isFlipped ? 0 : 1)
                .zIndex(self.isFlipped ? 0 : 1)

            // Back side
            backCard
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
        .onChange(of: word) { _ in
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
                        .font(.system(size: 14, weight: .bold, design: .rounded))
                        .foregroundColor(.secondary)
                        .padding([.top, .trailing], 16)
                }
                Spacer()
            }
            Text(self.word.kanji)
                .font(.system(size: 40, weight: .bold, design: .rounded))
                .foregroundColor(.primary)
        }
        .frame(maxWidth: .infinity, maxHeight: 300)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 3)
    }
    
    // Back side view
    private var backCard: some View {
        VStack {
            Spacer()
            Text(self.word.hiragana)
                .font(.system(size: 24, weight: .medium, design: .rounded))
                .foregroundColor(.primary)
            Text(self.word.meaning)
                .font(.system(size: 18, weight: .regular, design: .rounded))
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: 300)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 3)
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
