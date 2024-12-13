//
//  WordRowView.swift
//  Word
//
//  Created by Coby on 12/13/24.
//  Copyright © 2024 Coby. All rights reserved.
//

import SwiftUI

import CobyDS

struct WordRowView: View {
    
    private let word: Word
    
    init(word: Word) {
        self.word = word
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            HStack(alignment: .top) {
                Text(self.word.kanji)
                    .font(.pretendard(size: 22, weight: .bold))
                    .foregroundColor(Color.labelNormal)
                
                Spacer()
                
                Text("#\(self.word.number)")
                    .font(.pretendard(size: 12, weight: .bold))
                    .foregroundColor(Color.labelAssistive)
            }
            
            HStack {
                Text(self.word.hiragana)
                    .font(.pretendard(size: 16, weight: .medium))
                    .foregroundColor(Color.labelNeutral)
                
                Spacer()
                
                Text(self.word.meaning)
                    .font(.pretendard(size: 14, weight: .medium))
                    .foregroundColor(Color.labelAlternative)
            }
        }
        .padding(16)
        .background(Color.backgroundNormalNormal)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: Color.shadowStrong, radius: 4, x: 0, y: 2)
    }
}
