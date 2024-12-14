//
//  ProgressBarView.swift
//  Word
//
//  Created by Coby on 12/14/24.
//  Copyright © 2024 Coby. All rights reserved.
//

import SwiftUI

struct ProgressBarView: View {
    
    private let progress: Double // 0.0 ~ 1.0 값 (진행 비율)
    private let backgroundColor: Color // 배경 색상
    private let foregroundColor: Color // 진행 막대 색상
    
    init(progress: Double, backgroundColor: Color, foregroundColor: Color) {
        self.progress = progress
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                // Background bar
                Rectangle()
                    .fill(self.backgroundColor)
                    .frame(height: 8)
                    .cornerRadius(4)
                
                // Foreground bar
                Rectangle()
                    .fill(self.foregroundColor)
                    .frame(width: geometry.size.width * CGFloat(self.progress), height: 8)
                    .cornerRadius(4)
            }
        }
        .frame(height: 20)
    }
}
