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
    @State private var dragOffset: CGSize = .zero // 드래그 상태 추적
    @State private var isVisible: Bool = true // 카드 가시성 추적
    
    private let word: Word
    private let onRemembered: () -> Void // 외웠음
    private let onForgotten: () -> Void // 모르겠음
    
    init(word: Word, onRemembered: @escaping () -> Void, onForgotten: @escaping () -> Void) {
        self.word = word
        self.onRemembered = onRemembered
        self.onForgotten = onForgotten
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
        .offset(x: self.dragOffset.width, y: 0) // y는 고정
        .gesture(self.dragGesture) // 스와이프 제스처 적용
        .animation(.spring(response: 0.5, dampingFraction: 0.75, blendDuration: 0.1), value: self.dragOffset)
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
    
    // Drag gesture
    private var dragGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                // y 축을 고정하고 x 축만 추적
                self.dragOffset = CGSize(width: value.translation.width, height: 0)
            }
            .onEnded { value in
                if value.translation.width > 100 {
                    // 오른쪽으로 스와이프 → 외웠음
                    self.swipeCard(to: .right)
                    self.onRemembered()
                } else if value.translation.width < -100 {
                    // 왼쪽으로 스와이프 → 모르겠음
                    self.swipeCard(to: .left)
                    self.onForgotten()
                } else {
                    // 원래 위치로 복원
                    self.dragOffset = .zero
                }
            }
    }
    
    // 카드 스와이프 애니메이션
    private func swipeCard(to direction: SwipeDirection) {
        withAnimation {
            switch direction {
            case .left:
                self.dragOffset = CGSize(width: -1000, height: 0) // 왼쪽으로 사라짐
            case .right:
                self.dragOffset = CGSize(width: 1000, height: 0) // 오른쪽으로 사라짐
            }
        }
        
        // 카드가 사라지고 새로운 카드 나타나기
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.resetCard()
        }
    }
    
    // Reset card to front side
    private func resetCard() {
        withAnimation {
            self.isFlipped = false
            self.dragOffset = .zero
        }
    }
    
    // Flip the card
    private func flipCard() {
        withAnimation(.spring(response: 0.6, dampingFraction: 0.8, blendDuration: 0.2)) {
            self.isFlipped.toggle()
        }
    }
}

// 스와이프 방향
private enum SwipeDirection {
    case left, right
}
