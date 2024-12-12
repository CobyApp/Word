//
//  HomeView.swift
//  Word
//
//  Created by Coby on 12/12/24.
//  Copyright © 2024 Coby. All rights reserved.
//

import SwiftUI

import CobyDS
import ComposableArchitecture

struct HomeView: View {
    
    @Bindable private var store: StoreOf<HomeStore>
    
    init(store: StoreOf<HomeStore>) {
        self.store = store
    }
    
    private let jlptLevels: [(name: String, color: Color)] = [
        ("JLPT N3", .green),
        ("JLPT N2", .blue),
        ("JLPT N1", .red)
    ]
    
    private let ranges: [String] = [
        "Stage 1", "Stage 2", "Stage 3", "Stage 4", "Stage 5"
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            TopBarView(
                leftSide: .title,
                leftTitle: "単語百先生"
            )
            
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(jlptLevels, id: \.name) { level in
                        JLPTCardView(
                            levelName: level.name,
                            color: level.color,
                            ranges: ranges
                        )
                        .padding(.horizontal, 16)
                    }
                }
                .padding(.vertical, 16)
            }
            .background(Color.backgroundNormalAlternative)
        }
    }
}
