//
//  JLPTCardView.swift
//  Word
//
//  Created by Coby on 12/13/24.
//  Copyright © 2024 Coby. All rights reserved.
//

import SwiftUI

import CobyDS

struct JLPTCardView: View {
    
    private let levelName: String
    private let color: Color
    private let ranges: [String]
    private let onRangeTap: (Int) -> Void
    
    init(
        levelName: String,
        color: Color,
        ranges: [String],
        onRangeTap: @escaping (Int) -> Void
    ) {
        self.levelName = levelName
        self.color = color
        self.ranges = ranges
        self.onRangeTap = onRangeTap
    }
    
    var body: some View {
        VStack(spacing: 16) {
            Text(self.levelName)
                .font(.pretendard(size: 24, weight: .bold))
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(Color.staticWhite)
                .background(self.color)
            
            VStack(spacing: 8) {
                ForEach(Array(self.ranges.enumerated()), id: \.offset) { index, range in
                    Button(action: {
                        self.onRangeTap(index)
                    }) {
                        HStack {
                            Text(range)
                                .font(.pretendard(size: 18, weight: .medium))
                                .foregroundColor(Color.labelNormal)
                            
                            Spacer()
                            
                            Image(uiImage: UIImage.icForward)
                                .resizable()
                                .frame(width: 16, height: 16)
                                .foregroundColor(Color.labelAssistive)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: Color.shadowNormal, radius: 2, x: 0, y: 1)
                    }
                }
            }
            .padding(.horizontal, 8)
            .padding(.bottom, 12)
        }
        .background(Color.backgroundNormalNormal)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: Color.shadowStrong, radius: 4, x: 0, y: 2)
    }
}
